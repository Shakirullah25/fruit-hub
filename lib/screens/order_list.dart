import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fruit_salad_combo/constant/colors.dart';
import 'package:fruit_salad_combo/constant/my_strings.dart';
import 'package:fruit_salad_combo/services/basket_service.dart';
import 'package:fruit_salad_combo/widgets/checkout_sheet.dart';
import 'package:fruit_salad_combo/widgets/primary_button.dart';


class OrderList extends StatefulWidget {
  final bool fromAddToBasket;
  final String userName;
  const OrderList({super.key, this.fromAddToBasket = false, required this.userName});

  @override
  State<OrderList> createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  late List<Map<String, dynamic>> item;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _isLoading = true;
    EasyLoading.show(
      status: widget.fromAddToBasket ? "Adding order..." : "Fetching orders...",
    );
    _loadBasketItems();
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _isLoading = false;
      });
      EasyLoading.dismiss();
    });
  }

  void _loadBasketItems() {
    // Use basket service items if available, otherwise use default items
    if (BasketService.itemCount.value > 0) {
      item = BasketService.basketItems
          .map((basketItem) => basketItem.toMap())
          .toList();
    } else {
      item = [];
    }
  }

  void _removeItem(int index) {
    if (index < BasketService.basketItems.length) {
      final basketItem = BasketService.basketItems[index];
      BasketService.removeItem(basketItem.comboId);
      setState(() {
        _loadBasketItems();
      });
    }
  }

  List<Color> fruitColors = [
    AppColors.quinoContainerColor,
    AppColors.tropicalContainerColor,
    AppColors.glowingBerryColor,
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.scaffoldColor,
        appBar: AppBar(
          // centerTitle: true,
          toolbarHeight: 150,
          backgroundColor: AppColors.primaryColor,
          //automaticallyImplyLeading: false, // removes default back
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back, color: AppColors.scaffoldColor),
          ),
          title: Text(
            MyStrings.myBasket,
            style: TextStyle(
              fontSize: 22.spMin,
              fontWeight: FontWeight.w500,
              color: AppColors.scaffoldColor,
            ),
          ),
        ),
        body: _isLoading
            ? SizedBox()
            : item.isEmpty
            ? Padding(
                padding: EdgeInsets.only(left: 16.w, right: 16.w),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    //crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        MyStrings.emptyShoppingCart,

                        fit: BoxFit.contain,
                      ),
                      15.verticalSpace,
                      Text(
                        textAlign: TextAlign.center,
                        MyStrings.emptyBasketTxt,
                        style: TextStyle(
                          fontSize: 18.spMin,
                          color: AppColors.secondaryColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      20.verticalSpace,
                      PrimaryButton(
                        onPressed: () {
                          Navigator.pop(
                            context,
                          ); // Navigate back to MainScreen (home)
                        },
                        label: MyStrings.startShopping,
                        height: 0.060.sh,
                        width: 0.4.sw,
                      ),
                    ],
                  ),
                ),
              )
            : Padding(
                padding: EdgeInsets.only(top: 0.04.sh),
                child: ListView.separated(
                  itemCount: item.length,
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                        color:
                            Colors.white, // 👈 give it a color to show shadow
                        //borderRadius: BorderRadius.circular(12.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.06),
                            offset: Offset(0, 6.h),
                            blurRadius: 12.r,
                            spreadRadius: 0.5.r,
                          ),
                        ],
                      ),

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            //contentPadding: EdgeInsets.only(left: 10, right: 10),
                            leading: Container(
                              width: 65.w,
                              height: 65.h,
                              decoration: BoxDecoration(
                                color: fruitColors[index % fruitColors.length],
                                borderRadius: BorderRadius.circular(
                                  8.r,
                                ), // rectangular with rounded corners
                                border: Border.all(
                                  color:
                                      fruitColors[index % fruitColors.length],
                                  //color: AppColors.secondaryColor, // border color
                                  width: 1.5,
                                ),
                              ),
                              child: Image.asset(
                                item[index]["img"],
                                width: 30.w,
                                height: 30.h,
                                alignment: Alignment.center,
                              ),
                            ),
                            //tileColor: AppColors.secondar,
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item[index]["fruitName"],
                                  style: TextStyle(
                                    fontSize: 16.spMin,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.secondaryColor,
                                  ),
                                ),
                                SizedBox(height: 0.01.sh),
                                Text(
                                  item[index]["fruitQty"],
                                  style: TextStyle(
                                    fontSize: 14.spMin,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.secondaryColor,
                                  ),
                                ),
                              ],
                            ),
                            trailing: Text(
                              item[index]["fruitPrize"],
                              style: TextStyle(
                                fontSize: 16.spMin,
                                fontWeight: FontWeight.w500,
                                color: AppColors.secondaryColor,
                              ),
                            ),
                          ),
                          10.verticalSpace,
                          const Divider(color: AppColors.textFieldColor),
                          //10.verticalSpace,
                          TextButton(
                            onPressed: () {
                              showCupertinoDialog<bool>(
                                context: context,
                                builder: (BuildContext context) {
                                  return CupertinoAlertDialog(
                                    title: Text(
                                      'Delete Item',
                                      style: TextStyle(
                                        fontSize: 16.spMin,
                                        color: AppColors.secondaryColor,
                                      ),
                                    ),
                                    content: Text(
                                      'Are you sure you want to delete this item?',
                                      style: TextStyle(
                                        fontSize: 15.spMin,
                                        color: AppColors.secondaryColor,
                                        //fontFamily: GoogleFonts.poppins
                                      ),
                                    ),
                                    actions: <CupertinoDialogAction>[
                                      CupertinoDialogAction(
                                        child: Text(
                                          'Cancel',
                                          style: TextStyle(
                                            color: AppColors.secondaryColor,
                                          ),
                                        ),
                                        onPressed: () {
                                          Navigator.of(context).pop(false);
                                        },
                                      ),
                                      CupertinoDialogAction(
                                        isDestructiveAction: true,
                                        onPressed: () {
                                          _removeItem(index);
                                          Navigator.of(context).pop(true);
                                        },
                                        child: Text('Delete'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            child: Text(
                              "Remove",
                              style: TextStyle(
                                fontSize: 16.spMin,
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          10.verticalSpace,
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => SizedBox(height: 10.h),
                ),
              ),
        bottomNavigationBar: _isLoading
            ? const SizedBox.shrink()
            : item.isEmpty
            ? const SizedBox.shrink()
            : Padding(
                padding: EdgeInsets.only(
                  left: 0.04.sw,
                  bottom: 0.04.sh,
                  right: 0.04.sw,
                ),
                child: Row(
                  crossAxisAlignment:
                      CrossAxisAlignment.center, // keep row items aligned
                  children: [
                    Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start, // align text to the left
                      mainAxisSize: MainAxisSize
                          .min, // 👈 prevents column from expanding vertically
                      children: [
                        Text(
                          MyStrings.totalAmountTxt,
                          style: TextStyle(
                            fontSize: 16.spMin,
                            fontWeight: FontWeight.w500,
                            color: AppColors.secondaryColor,
                          ),
                        ),
                        SizedBox(height: 4.h), // add spacing between texts
                        Text(
                          '# ${BasketService.getTotalAmount().toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 24.spMin,
                            fontWeight: FontWeight.w600,
                            color: AppColors.secondaryColor,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    PrimaryButton(
                      label: MyStrings.checkOut,
                      onPressed: () {
                        showCheckoutSheet(context, widget.userName);
                      },
                      width: 0.50.sw,
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
