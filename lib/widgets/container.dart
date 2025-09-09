import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fruit_salad_combo/constant/colors.dart';

class FruitBasketContainer extends StatelessWidget {
  final String basketImgPath;
  final String? shadowImgPath;
  final MainAxisAlignment imgMainAxisAlignment;
  const FruitBasketContainer({
    super.key,
    required this.basketImgPath,
    this.shadowImgPath,
    this.imgMainAxisAlignment = MainAxisAlignment.end,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(16.r),
        topRight: Radius.circular(16.r),
      ),
      child: Container(
        width: 1.sw,
        height: 0.5.sh, // Takes 50% of the screen size
        color: AppColors.primaryColor,
        child: Column(
          mainAxisAlignment: imgMainAxisAlignment,
          children: [
            Image.asset(
              basketImgPath,
              //MyStrings.basketImgPath,
              width: 0.8.sw,
              height: 0.3.sh,
              fit: BoxFit.contain,
            ),
            SizedBox(height: 0.02.sh),
            if (shadowImgPath != null)
              Image.asset(
                shadowImgPath!,
                //MyStrings.shadowImgPath,
                width: 0.8.sw,
                height: 0.015.sh,
                fit: BoxFit.contain,
              ),
            SizedBox(height: 0.02.sh),
          ],
        ),
      ),
    );
  }
}
