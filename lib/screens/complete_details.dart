import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fruit_salad_combo/constant/colors.dart';
import 'package:fruit_salad_combo/constant/my_strings.dart';
import 'package:fruit_salad_combo/widgets/primary_button.dart';
import 'package:fruit_salad_combo/widgets/primary_textfield.dart';

void showCheckoutSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    backgroundColor: AppColors.scaffoldColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
    ),
    builder: (context) {
      return SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.only(top: 0.04.sh, left: 0.08.sw, right: 0.08.sw),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                MyStrings.deliveryAddress,
                style: TextStyle(
                  fontSize: 20.spMin,
                  fontWeight: FontWeight.w500,
                  color: AppColors.secondaryColor,
                ),
              ),
              SizedBox(height: 0.03.sh),
              PrimaryTextField(hintText: MyStrings.hintDeliveryAddress),
              //SizedBox(height: 0.03.sh),
              Padding(
                padding: EdgeInsets.only(bottom: 0.03.sh),
                child: Text(
                  MyStrings.no2Call,
                  style: TextStyle(
                    fontSize: 20.spMin,
                    fontWeight: FontWeight.w500,
                    color: AppColors.secondaryColor,
                  ),
                ),
              ),
              PrimaryTextField(hintText: MyStrings.numberHint),
              SizedBox(height: 0.03.sh),
              Row(
                children: [
                  Expanded(
                    child: PrimaryButton(
                      label: MyStrings.payOnDelivery,
                      backgroundColor: AppColors.scaffoldColor,
                      foregroundColor: AppColors.primaryColor,
                      onPressed: () {},
                      borderSide: BorderSide(color: AppColors.primaryColor),
                    ),
                  ),
                  SizedBox(width: 0.05.sw), // space between buttons
                  Expanded(
                    child: PrimaryButton(
                      onPressed: () {},
                      label: MyStrings.payWithCard, // 👈 give this a diff label
                      backgroundColor: AppColors.scaffoldColor,
                      foregroundColor: AppColors.primaryColor,
                      borderSide: BorderSide(color: AppColors.primaryColor),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 0.04.sw), // space between buttons
            ],
          ),
        ),
      );
    },
  );
}
