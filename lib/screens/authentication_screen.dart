import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fruit_salad_combo/widgets/primary_button.dart';
import 'package:fruit_salad_combo/constant/colors.dart';
import 'package:fruit_salad_combo/widgets/container.dart';
import 'package:fruit_salad_combo/constant/my_strings.dart';
import 'package:fruit_salad_combo/widgets/primary_textfield.dart';

class AuthenticationScreen extends StatelessWidget {
  const AuthenticationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.scaffoldColor,
        body: Column(
          children: [
            FruitBasketContainer(
              basketImgPath: MyStrings.basketImgPath,
              shadowImgPath: MyStrings.shadowImgPath,
            ),
            SizedBox(height: 0.06.sh),
            Padding(
              padding: EdgeInsets.only(left: 0.08.sw),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    MyStrings.firstName,
                    style: TextStyle(
                      fontSize: 20.spMin,
                      fontWeight: FontWeight.w500,
                      color: AppColors.secondaryColor,
                    ),
                  ),
                  SizedBox(height: 0.02.sh),
                  Padding(
                    padding: EdgeInsets.only(right: 0.1.sw),
                    child: PrimaryTextField(hintText: MyStrings.authHintTxt),
                  ),
                  SizedBox(height: 0.05.sh),
                  Padding(
                    padding: EdgeInsets.only(right: 0.08.sw),
                    child: PrimaryButton(
                      label: MyStrings.authButtonTxt,
                      onPressed: () => AuthenticationScreen(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
