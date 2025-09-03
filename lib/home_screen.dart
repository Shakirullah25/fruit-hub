import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fruit_salad_combo/button.dart';
import 'package:fruit_salad_combo/constant/colors.dart';
import 'package:fruit_salad_combo/container.dart';
import 'package:fruit_salad_combo/constant/my_strings.dart';
import 'package:fruit_salad_combo/textfield.dart';
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
          FruitBasketContainer(),
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
          textfield(outLineInputBorder),
          button(),
        ],
      ),
    );
  }
}
