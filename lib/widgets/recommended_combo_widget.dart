import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fruit_salad_combo/constant/colors.dart';

class RecommendedComboWidget extends StatelessWidget {
  final String comboImgPath;
  final String comboName;
  final String comboPrize;
  final void Function()? onPressed;
  final void Function()? onTap;
  final Color? color;
  const RecommendedComboWidget({
    super.key,
    required this.comboImgPath,
    required this.comboName,
    required this.comboPrize,
    required this.onPressed,
    required this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 0.5.sw,
      // height: 0.25.sh,
      decoration: BoxDecoration(
        color: color ?? AppColors.scaffoldColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(20),
            offset: Offset(0, 6.h),
            blurRadius: 12.r,
            spreadRadius: 0.5.r,
          ),
        ],
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Padding(
        padding: EdgeInsets.all(8.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                onPressed: onPressed,
                icon: Icon(
                  Icons.favorite_outline_outlined,
                  size: 16.spMin,
                  color: AppColors.primaryColor,
                ),
              ),
            ),
            //SizedBox(height: 8.h),
            Align(
              alignment: Alignment.center,
              child: Image.asset(
                comboImgPath,
                width: 80.w,
                height: 80.h,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              comboName,
              style: TextStyle(
                fontSize: 14.spMin,
                color: AppColors.secondaryColor,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 8.h),
            Row(
              children: [
                Text(
                  comboPrize,
                  style: TextStyle(
                    fontSize: 14.spMin,
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: EdgeInsets.only(right: 8.0).r,
                  child: Container(
                    alignment: Alignment.center,
                    width: 24.w,
                    height: 24.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.addContainerColor,
                    ),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12.r),
                      onTap: onTap,
                      child: Icon(
                        Icons.add,
                        size: 14.spMin,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
