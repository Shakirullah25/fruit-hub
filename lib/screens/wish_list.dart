import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fruit_salad_combo/constant/colors.dart';
import 'package:fruit_salad_combo/constant/my_strings.dart';
import 'package:fruit_salad_combo/services/basket_service.dart';
import 'package:fruit_salad_combo/services/wishlist_service.dart';
import 'package:fruit_salad_combo/widgets/primary_button.dart';

class WishList extends StatefulWidget {
  const WishList({super.key});

  @override
  State<WishList> createState() => _WishListState();
}

class _WishListState extends State<WishList> {
  late List<Map<String, dynamic>> item;
  bool _isLoading = true;
  Map<String, int> quantities = {};
  Map<String, bool> isUpdating = {};

  @override
  void initState() {
    super.initState();
    _isLoading = true;
    EasyLoading.show(status: "Fetching wishlist...");
    _loadWishlistItems();
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _isLoading = false;
      });
      EasyLoading.dismiss();
    });
  }

  void _loadWishlistItems() {
    // Use wishlist service items
    if (WishlistService.itemCount.value > 0) {
      item = WishlistService.wishlistItems
          .map((wishlistItem) => wishlistItem.toMap())
          .toList();
      // Initialize quantities from basket
      for (var wishlistItem in WishlistService.wishlistItems) {
        final existingIndex = BasketService.basketItems.indexWhere(
          (item) => item.comboId == wishlistItem.comboId,
        );
        if (existingIndex != -1) {
          quantities[wishlistItem.comboId] =
              int.tryParse(
                BasketService.basketItems[existingIndex].fruitQty.replaceAll(
                  RegExp(r'\D'),
                  '',
                ),
              ) ??
              0;
        }
      }
    } else {
      item = [];
    }
  }

  void _removeItem(int index) {
    if (index < WishlistService.wishlistItems.length) {
      final wishlistItem = WishlistService.wishlistItems[index];
      WishlistService.removeItem(wishlistItem.comboId);
      quantities.remove(wishlistItem.comboId); // Reset quantity state
      setState(() {
        _loadWishlistItems();
      });
    }
  }

  Future<void> _increaseQuantity(
    String comboId,
    String img,
    String fruitName,
    String fruitPrize,
  ) async {
    setState(() {
      isUpdating[comboId] = true;
      quantities[comboId] = (quantities[comboId] ?? 0) + 1;
    });
    // Calculate total price
    double basePrice =
        double.tryParse(fruitPrize.replaceAll(RegExp(r'[^\d.]'), '')) ?? 0.0;
    double totalPrice = basePrice * quantities[comboId]!;
    String formattedPrice = '# ${totalPrice.toStringAsFixed(2)}';
    final basketItem = BasketItem(
      img: img,
      fruitName: fruitName,
      fruitQty:
          "${quantities[comboId]} Pack${quantities[comboId]! > 1 ? 's' : ''}",
      fruitPrize: formattedPrice,
      comboId: comboId,
    );
    BasketService.addItem(basketItem);
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      isUpdating[comboId] = false;
    });
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          showCloseIcon: true,
          closeIconColor: AppColors.scaffoldColor,
          backgroundColor: AppColors.primaryColor,

          content: Text(
            'Basket successfully updated',
            style: TextStyle(
              fontSize: 16.spMin,
              color: AppColors.scaffoldColor,
            ),
          ),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  Future<void> _decreaseQuantity(String comboId, String fruitName) async {
    if ((quantities[comboId] ?? 0) > 0) {
      setState(() {
        isUpdating[comboId] = true;
        quantities[comboId] = quantities[comboId]! - 1;
      });
      if (quantities[comboId] == 0) {
        BasketService.removeItem(comboId);
        await Future.delayed(const Duration(milliseconds: 500));
        setState(() {
          isUpdating[comboId] = false;
        });
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              showCloseIcon: true,
              closeIconColor: AppColors.scaffoldColor,
              backgroundColor: AppColors.primaryColor,
              content: Text(
                'Basket successfully updated',
                style: TextStyle(
                  fontSize: 16.spMin,
                  color: AppColors.scaffoldColor,
                ),
              ),
              duration: const Duration(seconds: 2),
            ),
          );
        }
      } else {
        // Update quantity in basket
        final existingItems = BasketService.basketItems;
        final existingIndex = existingItems.indexWhere(
          (item) => item.comboId == comboId,
        );
        if (existingIndex != -1) {
          // Recalculate total price
          double basePrice =
              double.tryParse(
                existingItems[existingIndex].fruitPrize.replaceAll(
                  RegExp(r'[^\d.]'),
                  '',
                ),
              ) ??
              0.0;
          double totalPrice =
              basePrice /
              (quantities[comboId]! + 1) *
              quantities[comboId]!; // Since decreasing, divide by old qty * new
          // Better to parse base from original fruitPrize, but since it's total, need base.
          // Actually, since fruitPrize in wishlist is base, but in basket it's total.
          // Inconsistent.
          // To fix, perhaps store base price separately, but for now, since base is known, but in decrease, the existing fruitPrize is total for old qty.
          // So, totalPrice = (parse existing.fruitPrize) / (old qty) * new qty
          double currentTotal =
              double.tryParse(
                existingItems[existingIndex].fruitPrize.replaceAll(
                  RegExp(r'[^\d.]'),
                  '',
                ),
              ) ??
              0.0;
          int oldQty =
              int.tryParse(
                existingItems[existingIndex].fruitQty.replaceAll(
                  RegExp(r'\D'),
                  '',
                ),
              ) ??
              1; // Extract number
          double basePriceCalc = currentTotal / oldQty;
          double newTotal = basePriceCalc * quantities[comboId]!;
          String formattedPrice = '# ${newTotal.toStringAsFixed(2)}';
          final updatedItem = BasketItem(
            img: existingItems[existingIndex].img,
            fruitName: existingItems[existingIndex].fruitName,
            fruitQty:
                "${quantities[comboId]} Pack${quantities[comboId]! > 1 ? 's' : ''}",
            fruitPrize: formattedPrice,
            comboId: comboId,
          );
          BasketService.addItem(updatedItem);
        }
        await Future.delayed(const Duration(milliseconds: 500));
        setState(() {
          isUpdating[comboId] = false;
        });
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              showCloseIcon: true,
              closeIconColor: AppColors.scaffoldColor,
              backgroundColor: AppColors.primaryColor,

              content: Text(
                'Basket successfully updated',
                style: TextStyle(
                  fontSize: 16.spMin,
                  color: AppColors.scaffoldColor,
                ),
              ),
              duration: const Duration(seconds: 2),
            ),
          );
        }
      }
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
          //centerTitle: true,
          toolbarHeight: 150,
          backgroundColor: AppColors.primaryColor,

          //automaticallyImplyLeading: false, // removes default back
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back, color: AppColors.scaffoldColor),
          ),
          title: Text(
            MyStrings.myWishList,
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
                    children: [
                      Image.asset(
                        MyStrings.emptyShoppingCart,
                        fit: BoxFit.contain,
                      ),
                      15.verticalSpace,
                      Text(
                        textAlign: TextAlign.center,
                        "Your wishlist is empty",
                        style: TextStyle(
                          fontSize: 18.spMin,
                          color: AppColors.secondaryColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      20.verticalSpace,
                      PrimaryButton(
                        onPressed: () {
                          Navigator.pop(context); // Navigate back to MainScreen
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
                            // ignore: deprecated_member_use
                            color: Colors.black.withOpacity(0.06),
                            offset: Offset(0, 6.h),
                            blurRadius: 12.r,
                            spreadRadius: 0.5.r,
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          15.verticalSpace,
                          ListTile(
                            leading: Container(
                              width: 65.w,
                              height: 65.h,
                              decoration: BoxDecoration(
                                color: fruitColors[index % fruitColors.length],
                                borderRadius: BorderRadius.circular(8.r),
                                border: Border.all(
                                  color:
                                      fruitColors[index % fruitColors.length],
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
                            title: Text(
                              item[index]["fruitName"],
                              style: TextStyle(
                                fontSize: 16.spMin,
                                fontWeight: FontWeight.w500,
                                color: AppColors.secondaryColor,
                              ),
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

                          15.verticalSpace,
                          const Divider(color: AppColors.textFieldColor),
                          15.verticalSpace,
                          Row(
                            children: [
                              TextButton(
                                onPressed: () {
                                  showCupertinoDialog<bool>(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return CupertinoAlertDialog(
                                        title: Text(
                                          'Remove from Wishlist',
                                          style: TextStyle(
                                            fontSize: 16.spMin,
                                            color: AppColors.secondaryColor,
                                          ),
                                        ),
                                        content: Text(
                                          'Do you really want to remove this item?',
                                          style: TextStyle(
                                            fontSize: 15.spMin,
                                            color: AppColors.secondaryColor,
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
                                              Navigator.of(context).pop(true);
                                            },
                                          ),
                                          CupertinoDialogAction(
                                            isDestructiveAction: true,
                                            onPressed: () {
                                              _removeItem(index);
                                              Navigator.of(context).pop(false);
                                            },
                                            child: Text('Remove'),
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
                              const Spacer(),
                              Flexible(
                                fit: FlexFit.loose,
                                child: Padding(
                                  padding: EdgeInsets.only(right: 16.w),
                                  child:
                                      (quantities[WishlistService
                                                  .wishlistItems[index]
                                                  .comboId] ??
                                              0) >
                                          0
                                      ? Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                color: AppColors.primaryColor,

                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(5.r),
                                                ),
                                              ),
                                              child: IconButton(
                                                onPressed: () =>
                                                    _decreaseQuantity(
                                                      WishlistService
                                                          .wishlistItems[index]
                                                          .comboId,
                                                      WishlistService
                                                          .wishlistItems[index]
                                                          .fruitName,
                                                    ),
                                                icon: Icon(
                                                  Icons.remove,
                                                  color:
                                                      AppColors.scaffoldColor,
                                                  size: 20.sp,
                                                ),
                                              ),
                                            ),
                                            10.horizontalSpace,
                                            Container(
                                              width: 40.w,
                                              alignment: Alignment.center,
                                              child:
                                                  (isUpdating[WishlistService
                                                          .wishlistItems[index]
                                                          .comboId] ??
                                                      false)
                                                  ? SizedBox(
                                                      width: 0.05.sw,
                                                      height: 0.05.sw,
                                                      child:
                                                          CircularProgressIndicator(
                                                            strokeWidth: 2,
                                                            color: AppColors
                                                                .primaryColor,
                                                          ),
                                                    )
                                                  : Text(
                                                      '${quantities[WishlistService.wishlistItems[index].comboId] ?? 0}',
                                                      style: TextStyle(
                                                        fontSize: 16.spMin,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: AppColors
                                                            .secondaryColor,
                                                      ),
                                                    ),
                                            ),
                                            10.horizontalSpace,
                                            Container(
                                              decoration: BoxDecoration(
                                                color: AppColors.primaryColor,

                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(5.r),
                                                ),
                                              ),
                                              child: IconButton(
                                                onPressed: () =>
                                                    _increaseQuantity(
                                                      WishlistService
                                                          .wishlistItems[index]
                                                          .comboId,
                                                      WishlistService
                                                          .wishlistItems[index]
                                                          .img,
                                                      WishlistService
                                                          .wishlistItems[index]
                                                          .fruitName,
                                                      WishlistService
                                                          .wishlistItems[index]
                                                          .fruitPrize,
                                                    ),
                                                icon: Icon(
                                                  Icons.add,
                                                  color:
                                                      AppColors.scaffoldColor,
                                                  size: 20.sp,
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      : PrimaryButton(
                                          onPressed: () => _increaseQuantity(
                                            WishlistService
                                                .wishlistItems[index]
                                                .comboId,
                                            WishlistService
                                                .wishlistItems[index]
                                                .img,
                                            WishlistService
                                                .wishlistItems[index]
                                                .fruitName,
                                            WishlistService
                                                .wishlistItems[index]
                                                .fruitPrize,
                                          ),
                                          label: MyStrings.add2Basket,
                                          height: 0.050.sh,
                                          width: 0.4.sw,
                                        ),
                                ),
                              ),
                            ],
                          ),
                          15.verticalSpace,
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => SizedBox(height: 10.h),
                ),
              ),
      ),
    );
  }
}
