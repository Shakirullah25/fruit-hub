import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fruit_salad_combo/constant/colors.dart';
import 'package:fruit_salad_combo/constant/my_strings.dart';
import 'package:fruit_salad_combo/model/combo_details.dart';
import 'package:fruit_salad_combo/screens/order_list.dart';
import 'package:fruit_salad_combo/services/basket_service.dart';
import 'package:fruit_salad_combo/services/wishlist_service.dart';
import 'package:fruit_salad_combo/widgets/container.dart';
import 'package:fruit_salad_combo/widgets/primary_button.dart';

class AddToBasketScreen extends StatefulWidget {
  final ComboDetails comboDetails;
  final String userName;
  const AddToBasketScreen({super.key, required this.comboDetails, required this.userName});

  @override
  State<AddToBasketScreen> createState() => _AddToBasketScreenState();
}

class _AddToBasketScreenState extends State<AddToBasketScreen> {
  int quantity = 1;
  bool _isInWishlist = false;
  //bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _isInWishlist = WishlistService.isInWishlist(
      "${widget.comboDetails.imgPath}_${widget.comboDetails.fruitName}",
    );
  }

  void _incrementQuantity() {
    setState(() {
      quantity++;
    });
  }

  void _decrementQuantity() {
    if (quantity > 1) {
      setState(() {
        quantity--;
      });
    }
  }

  double _getBasePrice() {
    // Parse the fruitPrice string to double, removing any currency symbols
    String priceStr = widget.comboDetails.fruitPrice.replaceAll(
      RegExp(r'[^\d.]'),
      '',
    );
    return double.tryParse(priceStr) ?? 0.0;
  }

  double _getTotalPrice() {
    return _getBasePrice() * quantity;
  }

  String _formatPrice(double price) {
    return '# ${price.toStringAsFixed(2)}';
  }

  void _toggleWishlist() {
    final comboId =
        "${widget.comboDetails.imgPath}_${widget.comboDetails.fruitName}";
    if (_isInWishlist) {
      WishlistService.removeItem(comboId);
      setState(() {
        _isInWishlist = false;
      });
    } else {
      final wishlistItem = WishlistItem(
        img: widget.comboDetails.imgPath,
        fruitName: widget.comboDetails.fruitName,
        fruitQty: "1 Pack", // Default quantity for wishlist
        fruitPrize: widget.comboDetails.fruitPrice,
        comboId: comboId,
      );
      bool added = WishlistService.addItem(wishlistItem);
      if (added) {
        setState(() {
          _isInWishlist = true;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              '${widget.comboDetails.fruitName} is already in wishlist',
            ),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    }
  }

  void _addToBasket() {
    final basketItem = BasketItem(
      img: widget.comboDetails.imgPath,
      fruitName: widget.comboDetails.fruitName,
      fruitQty: "$quantity Pack${quantity > 1 ? 's' : ''}",
      fruitPrize: _formatPrice(_getTotalPrice()),
      comboId:
          "${widget.comboDetails.imgPath}_${widget.comboDetails.fruitName}", // Using imgPath + fruitName as unique identifier
    );

    BasketService.addItem(basketItem);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => OrderList(fromAddToBasket: true, userName: widget.userName),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.scaffoldColor,
        body: Stack(
          children: [
            // Basket Image + Back Button
            Column(
              children: [
                Stack(
                  children: [
                    FruitBasketContainer(
                      basketImgPath: widget.comboDetails.imgPath,
                      //basketImgPath: MyStrings.quinoaImg2,
                      imgMainAxisAlignment: MainAxisAlignment.center,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(
                          Icons.arrow_back,
                          color: AppColors.scaffoldColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),

            // Overlapping Container
            Positioned(
              top: 0.42.sh, // adjust this value for how much overlap you want
              child: Container(
                width: 1.sw,
                //height: 0.55.sh,
                decoration: BoxDecoration(
                  color: AppColors.scaffoldColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.r),
                    topRight: Radius.circular(30.r),
                  ),
                ),
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 0.04.sh, left: 0.08.sw),
                        child: Text(
                          widget.comboDetails.fruitName,
                          //MyStrings.quinoFruitUpperCase,
                          style: TextStyle(
                            fontSize: 32.spMin,
                            fontWeight: FontWeight.w500,
                            color: AppColors.secondaryColor,
                          ),
                        ),
                      ),
                      SizedBox(height: 0.03.sh),
                      Padding(
                        padding: EdgeInsets.only(left: 0.08.sw, right: 0.08.sw),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            // Minus button
                            InkWell(
                              onTap: _decrementQuantity,
                              child: Container(
                                alignment: Alignment.center,
                                width: 32.w,
                                height: 32.h,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: AppColors.countBorderColor,
                                    width: 1,
                                  ), // 👈 border
                                  color: AppColors.scaffoldColor,
                                ),
                                child: Icon(
                                  Icons.remove,
                                  size: 16.spMin,
                                  color: AppColors.secondaryColor,
                                ),
                              ),
                            ),

                            SizedBox(width: 0.07.sw),

                            // Quantity number
                            Text(
                              quantity.toString(),
                              style: TextStyle(
                                fontSize: 24.spMin,
                                fontWeight: FontWeight.w400,
                                color: AppColors.secondaryColor,
                              ),
                            ),
                            SizedBox(width: 0.07.sw),
                            // Plus button
                            InkWell(
                              onTap: _incrementQuantity,
                              child: Container(
                                alignment: Alignment.center,
                                width: 32.w,
                                height: 32.h,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.addContainerColor,
                                ),
                                child: Icon(
                                  Icons.add,
                                  size: 16.spMin,
                                  color: AppColors.primaryColor,
                                ),
                              ),
                            ),
                            const Spacer(),
                            Text(
                              _formatPrice(_getTotalPrice()),
                              //MyStrings.comboPrize2k,
                              style: TextStyle(
                                fontSize: 24.spMin,
                                fontWeight: FontWeight.w500,
                                color: AppColors.secondaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 0.03.sh),
                      Divider(
                        thickness: 0.5,
                        color: const Color.fromARGB(89, 194, 189, 189),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 0.08.sw, top: 0.03.sh),
                        child: Container(
                          padding: EdgeInsets.only(
                            bottom: 1.h,
                          ), // 👈 space between text and underline
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: AppColors.primaryColor,
                                width: 2.5.w,
                              ),
                            ),
                          ),
                          child: Text(
                            MyStrings.detailsHeader,
                            style: TextStyle(
                              fontSize: 20.spMin,
                              fontWeight: FontWeight.w500,
                              color: AppColors.secondaryColor,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 0.08.sw,
                          top: 0.03.sh,
                          right: 0.08.sw,
                        ),
                        child: Text(
                          widget.comboDetails.description,
                          //MyStrings.detailsInfo,
                          style: TextStyle(
                            fontSize: 16.spMin,
                            fontWeight: FontWeight.w500,
                            color: AppColors.secondaryColor,
                          ),
                        ),
                      ),
                      SizedBox(height: 0.03.sh),
                      Divider(
                        thickness: 0.5.sp,
                        color: const Color.fromARGB(89, 194, 189, 189),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 0.08.sw,
                          top: 0.03.sh,
                          right: 0.08.sw,
                        ),
                        child: RichText(
                          text: TextSpan(
                            style: TextStyle(
                              fontSize: 14.spMin,
                              fontWeight: FontWeight.w400,
                              color: AppColors.secondaryColor,
                            ),
                            children: [
                              TextSpan(text: MyStrings.detailInfo2),
                              TextSpan(
                                text: widget.comboDetails.shortName,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              TextSpan(text: MyStrings.detailInfo3),
                            ],
                          ),
                        ),

                      ),
                      //const Spacer(),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 0.08.sw,
                          top: 0.03.sh,
                          right: 0.08.sw,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          //crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: _toggleWishlist,
                              child: Container(
                                alignment: Alignment.center,
                                width: 48.w,
                                height: 48.h,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.addContainerColor,
                                ),
                                child: Icon(
                                  _isInWishlist
                                      ? Icons.favorite
                                      : Icons.favorite_outline,
                                  size: 24.spMin,
                                  color: AppColors.primaryColor,
                                ),
                              ),
                            ),
                            const Spacer(),
                            PrimaryButton(
                              label: MyStrings.add2Basket,
                              onPressed: _addToBasket,
                              width: 0.50.sw,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}