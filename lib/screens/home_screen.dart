import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fruit_salad_combo/constant/colors.dart';
import 'package:fruit_salad_combo/constant/my_strings.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.scaffoldColor,
        appBar: AppBar(
          backgroundColor: AppColors.scaffoldColor,
          foregroundColor: AppColors.scaffoldColor,
          leading: Image.asset(
            MyStrings.navImg,
            width: 0.01.sw,
            height: 0.001.sh,
            fit: BoxFit.contain,
          ),
          actions: [
            Image.asset(
            MyStrings.myBasketImg,
            width: 0.01.sw,
            height: 0.001.sh,
            fit: BoxFit.contain,
          ),
          ],
        ),
      ),
    );
  }
}
