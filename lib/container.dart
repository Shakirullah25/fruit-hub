import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fruit_salad_combo/colors.dart';
import 'package:fruit_salad_combo/my_strings.dart';

class FruitBasketContainer extends StatelessWidget {
  const FruitBasketContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16).r,
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16).r,
          topRight: Radius.circular(16).r,
        ),
        child: Container(
          width: 375.w,
          height: 469.h,
          color: AppColors.primaryColor,
          child: Align(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  MyStrings.basketImgPath,
                  width: 301.w,
                  height: 281.21.h,
                  // height: size.height,
                  fit: BoxFit.contain,
                ),
                Image.asset(
                  MyStrings.shadowImgPath,
                  width: 301.w,
                  height: 12.h,
                  // height: size.height,
                  fit: BoxFit.contain,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
