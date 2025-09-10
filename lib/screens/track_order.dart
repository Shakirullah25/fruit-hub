import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fruit_salad_combo/constant/colors.dart';
import 'package:fruit_salad_combo/constant/my_strings.dart';

class TrackOrder extends StatelessWidget {
  const TrackOrder({super.key});

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
                onPressed: () {},
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
                MyStrings.deliveryStatus,
                style: TextStyle(
                  fontSize: 24.spMin,
                  fontWeight: FontWeight.w500,
                  color: AppColors.scaffoldColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
