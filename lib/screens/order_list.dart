import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fruit_salad_combo/constant/colors.dart';
import 'package:fruit_salad_combo/constant/my_strings.dart';
import 'package:fruit_salad_combo/services/basket_service.dart';
import 'package:fruit_salad_combo/widgets/checkout_sheet.dart';
import 'package:fruit_salad_combo/widgets/primary_button.dart';

class OrderList extends StatefulWidget {
  const OrderList({super.key});

  @override
  State<OrderList> createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  late List<Map<String, dynamic>> item;

  @override
  void initState() {
    super.initState();
    _loadBasketItems();
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
          toolbarHeight: 150,
          backgroundColor: AppColors.primaryColor,
          automaticallyImplyLeading: false, // removes default back
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ElevatedButton.icon(
                onPressed: () => Navigator.pop(context),
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: AppColors.secondaryColor,
                  size: 18.spMin,
                ),
                label: Align(
                  alignment: Alignment.center,
                  child: Text(
                    MyStrings.goBack,
                    style: TextStyle(
                      fontSize: 14.spMin,
                      fontWeight: FontWeight.w400,
                      color: AppColors.secondaryColor,
                    ),
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.scaffoldColor,
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 6.h,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.r),
                  ),
                ),
              ),
              SizedBox(width: 0.1.sw),
              Text(
                MyStrings.myBasket,
                style: TextStyle(
                  fontSize: 22.spMin,
                  fontWeight: FontWeight.w500,
                  color: AppColors.scaffoldColor,
                ),
              ),
            ],
          ),
        ),
        body: item.isEmpty
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
                        // height: 0.25.sh,
                        // width: 0.25.sh,
                        // height: 0.1.sh,
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
                    return Dismissible(
                      key: ValueKey(item[index]["fruitName"]),
                      direction: DismissDirection.endToStart,
                      background: Container(
                        color: AppColors.red,
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.only(right: 20.w),
                        child: Icon(
                          Icons.delete,
                          color: AppColors.scaffoldColor,
                          size: 28.spMin,
                        ),
                      ),
                      confirmDismiss: (direction) async {
                        return await showCupertinoDialog<bool>(
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
                                        Navigator.of(context).pop(true);
                                      },
                                      child: Text('Delete'),
                                    ),
                                  ],
                                );
                              },
                            ) ??
                            false;
                      },
                      onDismissed: (direction) {
                        _removeItem(index);
                      },
                      child: ListTile(
                        leading: Container(
                          width: 65.w,
                          height: 65.h,
                          decoration: BoxDecoration(
                            color: fruitColors[index % fruitColors.length],
                            borderRadius: BorderRadius.circular(
                              8.r,
                            ), // rectangular with rounded corners
                            border: Border.all(
                              color: fruitColors[index % fruitColors.length],
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
                    );
                  },
                  separatorBuilder: (context, index) => Padding(
                    padding: EdgeInsets.only(top: 0.02.sh, bottom: 0.02.sh),
                    child: Divider(
                      thickness: 0.5,
                      color: const Color.fromARGB(157, 194, 189, 189),
                    ),
                  ),
                ),
              ),
        bottomNavigationBar: item.isEmpty
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
                        showCheckoutSheet(context);
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







// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:fruit_salad_combo/constant/colors.dart';
// import 'package:fruit_salad_combo/constant/my_strings.dart';
// import 'package:fruit_salad_combo/widgets/checkout_sheet.dart';
// import 'package:fruit_salad_combo/widgets/primary_button.dart';

// class OrderList extends StatefulWidget {
//   const OrderList({super.key});

//   @override
//   State<OrderList> createState() => _OrderListState();
// }

// class _OrderListState extends State<OrderList> {
//   List<Map<String, dynamic>> item = [
//     {
//       "img": MyStrings.quinoaImg,
//       "fruitName": MyStrings.quinoFruit,
//       "fruitQty": "2 Packs",
//       "fruitPrize": MyStrings.comboPrize2k,
//     },
//     {
//       "img": MyStrings.tropicalFruitImg,
//       "fruitName": MyStrings.tropicalFruit,
//       "fruitQty": "2 Packs",
//       "fruitPrize": MyStrings.comboPrize2k,
//     },
//     {
//       "img": MyStrings.glowingBerryImg,
//       "fruitName": MyStrings.glowingBerry,
//       "fruitQty": "2 Packs",
//       "fruitPrize": MyStrings.comboPrize2k,
//     },

//     // ...
//   ];

//   List<Color> fruitColors = [
//     AppColors.quinoContainerColor,
//     AppColors.tropicalContainerColor,
//     AppColors.glowingBerryColor,
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: AppColors.scaffoldColor,
//         appBar: AppBar(
//           toolbarHeight: 150,
//           backgroundColor: AppColors.primaryColor,
//           automaticallyImplyLeading: false, // removes default back
//           title: Row(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               ElevatedButton.icon(
//                 onPressed: () {},
//                 icon: Icon(
//                   Icons.arrow_back_ios,
//                   color: AppColors.secondaryColor,
//                   size: 18.spMin,
//                 ),
//                 label: Align(
//                   alignment: Alignment.center,
//                   child: Text(
//                     MyStrings.goBack,
//                     style: TextStyle(
//                       fontSize: 14.spMin,
//                       fontWeight: FontWeight.w400,
//                       color: AppColors.secondaryColor,
//                     ),
//                   ),
//                 ),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: AppColors.scaffoldColor,
//                   padding: EdgeInsets.symmetric(
//                     horizontal: 10.w,
//                     vertical: 6.h,
//                   ),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(25.r),
//                   ),
//                 ),
//               ),
//               SizedBox(width: 0.1.sw),
//               Text(
//                 MyStrings.myBasket,
//                 style: TextStyle(
//                   fontSize: 22.spMin,
//                   fontWeight: FontWeight.w500,
//                   color: AppColors.scaffoldColor,
//                 ),
//               ),
//             ],
//           ),
//         ),
//         body: Padding(
//           padding: EdgeInsets.only(top: 0.04.sh),
//           child: ListView.separated(
//             itemCount: 3,
//             itemBuilder: (context, index) {
//               return Dismissible(
//                 key: ValueKey(item[index]["fruitName"]),
//                 direction: DismissDirection.endToStart,
//                 background: Container(
//                   color: Colors.red,
//                   alignment: Alignment.centerRight,
//                   padding: EdgeInsets.only(right: 20.w),
//                   child: Icon(
//                     Icons.delete,
//                     color: Colors.white,
//                     size: 28.spMin,
//                   ),
//                 ),
//                 confirmDismiss: (direction) async {
//                   return await showCupertinoDialog<bool>(
//                     context: context,
//                     builder: (BuildContext context) {
//                       return CupertinoAlertDialog(
//                         title: Text('Delete Item'),
//                         content: Text('Are you sure you want to delete this item?'),
//                         actions: <CupertinoDialogAction>[
//                           CupertinoDialogAction(
//                             child: Text('Cancel'),
//                             onPressed: () {
//                               Navigator.of(context).pop(false);
//                             },
//                           ),
//                           CupertinoDialogAction(
//                             isDestructiveAction: true,
//                             onPressed: () {
//                               Navigator.of(context).pop(true);
//                             },
//                             child: Text('Delete'),
//                           ),
//                         ],
//                       );
//                     },
//                   ) ?? false;
//                 },
//                 onDismissed: (direction) {
//                   setState(() {
//                     item.removeAt(index);
//                   });
//                 },
//                 child: ListTile(
//                   leading: Container(
//                     width: 65.w,
//                     height: 65.h,
//                     decoration: BoxDecoration(
//                       color: fruitColors[index % fruitColors.length],
//                       borderRadius: BorderRadius.circular(
//                         8.r,
//                       ), // rectangular with rounded corners
//                       border: Border.all(
//                         color: fruitColors[index % fruitColors.length],
//                         //color: AppColors.secondaryColor, // border color
//                         width: 1.5,
//                       ),
//                     ),
//                     child: Image.asset(
//                       item[index]["img"],
//                       width: 30.w,
//                       height: 30.h,
//                       alignment: Alignment.center,
//                     ),
//                   ),
//                   //tileColor: AppColors.secondar,
//                   title: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         item[index]["fruitName"],
//                         style: TextStyle(
//                           fontSize: 16.spMin,
//                           fontWeight: FontWeight.w500,
//                           color: AppColors.secondaryColor,
//                         ),
//                       ),
//                       SizedBox(height: 0.01.sh),
//                       Text(
//                         item[index]["fruitQty"],
//                         style: TextStyle(
//                           fontSize: 14.spMin,
//                           fontWeight: FontWeight.w400,
//                           color: AppColors.secondaryColor,
//                         ),
//                       ),
//                     ],
//                   ),
//                   trailing: Text(
//                     item[index]["fruitPrize"],
//                     style: TextStyle(
//                       fontSize: 16.spMin,
//                       fontWeight: FontWeight.w500,
//                       color: AppColors.secondaryColor,
//                     ),
//                   ),
//                 ),
//               );
//             },
//             separatorBuilder: (context, index) => Padding(
//               padding: EdgeInsets.only(top: 0.02.sh, bottom: 0.02.sh),
//               child: Divider(
//                 thickness: 0.5,
//                 color: const Color.fromARGB(157, 194, 189, 189),
//               ),
//             ),
//           ),
//         ),
//         bottomNavigationBar: Padding(
//           padding: EdgeInsets.only(
//             left: 0.04.sw,
//             bottom: 0.04.sh,
//             right: 0.04.sw,
//           ),
//           child: Row(
//             crossAxisAlignment:
//                 CrossAxisAlignment.center, // keep row items aligned
//             children: [
//               Column(
//                 crossAxisAlignment:
//                     CrossAxisAlignment.start, // align text to the left
//                 mainAxisSize: MainAxisSize
//                     .min, // 👈 prevents column from expanding vertically
//                 children: [
//                   Text(
//                     MyStrings.totalAmountTxt,
//                     style: TextStyle(
//                       fontSize: 16.spMin,
//                       fontWeight: FontWeight.w500,
//                       color: AppColors.secondaryColor,
//                     ),
//                   ),
//                   SizedBox(height: 4.h), // add spacing between texts
//                   Text(
//                     MyStrings.totalAmount,
//                     style: TextStyle(
//                       fontSize: 24.spMin,
//                       fontWeight: FontWeight.w600,
//                       color: AppColors.secondaryColor,
//                     ),
//                   ),
//                 ],
//               ),
//               const Spacer(),
//               PrimaryButton(
//                 label: MyStrings.checkOut,
//                 onPressed: () {
//                   showCheckoutSheet(context);
//                 },
//                 width: 0.50.sw,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
