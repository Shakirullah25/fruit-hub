import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fruit_salad_combo/constant/colors.dart';
import 'package:fruit_salad_combo/constant/my_strings.dart';
import 'package:google_fonts/google_fonts.dart';

Padding button() {
  return Padding(
    padding: EdgeInsets.only(left: 0.1.sw, right: 0.1.sw),
    child: SizedBox(
      width: double.infinity,
      height: 0.065.sh,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10).r, // match TextField
          ),
          backgroundColor: AppColors.primaryColor,
          foregroundColor: AppColors.buttonTxtColor,
          padding: EdgeInsets.symmetric(vertical: 12.h),
        ),
        child: Text(
          MyStrings.buttonTxt,
          style: GoogleFonts.darkerGrotesque(
            fontSize: 16.spMin,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    ),
  );
}
