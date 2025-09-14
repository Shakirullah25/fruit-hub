import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fruit_salad_combo/constant/colors.dart';
import 'package:fruit_salad_combo/constant/my_strings.dart';
import 'package:fruit_salad_combo/widgets/primary_textfield.dart';

// A private helper function to build the Text Widget structure.

Widget _buildTextWidget({
  required String title,
  double? fontSize,
  Color? color,
}) {
  return Text(
    title,
    style: TextStyle(
      fontSize: fontSize ?? 20.spMin,
      fontWeight: FontWeight.w500,
      color: color ?? AppColors.secondaryColor,
    ),
  );
}

// A private helper function to build the core modal sheet structure.
// This handles the Stack, close button, and padding, making it reusable.
Widget _buildSheetContent({
  required BuildContext context,
  //required String title,
  required Widget child,
}) {
  return Stack(
    clipBehavior: Clip.none,
    children: [
      Padding(
        padding: EdgeInsets.only(top: 0.01.sh),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 0.03.sh),
            child,
          ],
        ),
      ),
      Positioned(
        top: -0.07.sh,
        left: 0,
        right: 0,
        child: Center(
          child: InkWell(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: 48.w,
              height: 48.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.scaffoldColor,
              ),
              child: Icon(
                Icons.close,
                color: AppColors.secondaryColor,
                size: 24.spMin,
                weight: 100,
              ),
            ),
          ),
        ),
      ),
    ],
  );
}

// Function to show the 'Pay with Card' sheet.
void showPayWithCardSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    backgroundColor: AppColors.scaffoldColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
    ),
    isScrollControlled: true,
    builder: (context) {
      return _buildSheetContent(
        context: context,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 0.06.sw, right: 0.06.sw),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTextWidget(title: MyStrings.cardHolderName),
                  10.verticalSpace,
                  PrimaryTextField(hintText: MyStrings.cardHolderHintName),
                  _buildTextWidget(title: MyStrings.cardNumber),
                  10.verticalSpace,
                  PrimaryTextField(hintText: MyStrings.cardNumberHint),
                  //SizedBox(height: 0.03.sh),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildTextWidget(title: MyStrings.date),

                            PrimaryTextField(hintText: MyStrings.dateHint),
                          ],
                        ),
                      ),
                      SizedBox(width: 0.1.sw),
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            _buildTextWidget(title: MyStrings.ccv),

                            PrimaryTextField(hintText: MyStrings.ccvHint),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 0.01.sh),
            GestureDetector(
              onTap: () {
                print("Complete Order Button Tapped");
              },
              child: SizedBox(
                width: double.infinity,
                height: 0.1.sh,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor, // Outer background
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: SizedBox(
                      width: 150.w,
                      height: 50.h,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: AppColors.scaffoldColor,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        //color: AppColors.scaffoldColor,
                        child: Center(
                          child: _buildTextWidget(
                            title: MyStrings.completeOrder,
                            fontSize: 16.spMin,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // SizedBox(height: 0.04.sh),
          ],
        ),
      );
    },
  );
}



// child: PrimaryButton(
              //   onPressed: () {},
              //   label: MyStrings.completeOrder,
              //   backgroundColor: AppColors.scaffoldColor,
              // ),
              // child: PrimaryButton(
              //   onPressed: () {},
              //   label: MyStrings.completeOrder,
              //   backgroundColor:
              //       Colors.transparent, // Set the button to be transparent
              //   foregroundColor: AppColors.scaffoldColor,
              //   borderSide: BorderSide.none, // Remove the border
              // ),