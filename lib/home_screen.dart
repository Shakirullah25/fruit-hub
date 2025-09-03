import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fruit_salad_combo/colors.dart';
import 'package:fruit_salad_combo/my_strings.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //final size = MediaQuery.of(context).size;

    final outLineInputBorder = OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.textFieldColor),
      borderRadius: BorderRadius.all(Radius.circular(10)).r,
    );
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      //appBar: AppBar(backgroundColor: AppColors.primaryColor),
      body: Column(
        children: [
          Padding(
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
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 30.w, bottom: 20.h),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  MyStrings.firstName,
                  style: GoogleFonts.darkerGrotesque(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.firstNameColor,
                  ),
                ),
              ),
            ),
          ),
          Padding(
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
          ),
          Padding(
            padding: EdgeInsets.only(left: 30.w, right: 30.w),
            child: SizedBox(
              width: double.infinity,
              height: 56.h,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      10,
                    ).r, // match TextField
                  ),
                  backgroundColor: AppColors.primaryColor,
                  foregroundColor: AppColors.buttonTxtColor,
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                ),
                child: Text(
                  MyStrings.buttonTxt,
                  style: GoogleFonts.darkerGrotesque(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
