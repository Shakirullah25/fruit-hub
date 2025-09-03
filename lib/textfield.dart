 import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fruit_salad_combo/colors.dart';
import 'package:fruit_salad_combo/my_strings.dart';

Padding textfield(OutlineInputBorder outLineInputBorder) {
    return Padding(
          padding: EdgeInsets.only(left: 30.w, right: 30.w, bottom: 50.h),
          child: SizedBox(
            height: 56.h,
            child: TextField(
              style: TextStyle(fontSize: 16.sp),
              showCursor: true,
              cursorColor: AppColors.primaryColor,
              decoration: InputDecoration(
                hintText: MyStrings.hintTxt,
                hintStyle: TextStyle(
                  color: AppColors.hintTxtColor,
                  fontSize: 16.sp,
                ),
                fillColor: AppColors.textFieldColor,
                filled: true,
                contentPadding: EdgeInsets.symmetric(
                  vertical: 16.h,
                  horizontal: 12.w,
                ).r,
                enabledBorder: outLineInputBorder,
                focusedBorder: outLineInputBorder,
              ),
            ),
          ),
        );
  }