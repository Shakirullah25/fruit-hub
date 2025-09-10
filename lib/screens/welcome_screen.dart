import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fruit_salad_combo/constant/colors.dart';
import 'package:fruit_salad_combo/constant/my_strings.dart';
import 'package:fruit_salad_combo/screens/authentication_screen.dart';
import 'package:fruit_salad_combo/widgets/primary_button.dart';
import 'package:fruit_salad_combo/widgets/container.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.scaffoldColor,
        //appBar: AppBar(backgroundColor: AppColors.primaryColor),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FruitBasketContainer(
              basketImgPath: MyStrings.fruitBinBasket,
              shadowImgPath: MyStrings.shadowImgPath,
            ),
            SizedBox(height: 0.06.sh),
            Padding(
              padding: EdgeInsets.only(left: 0.08.sw),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start, // align text & button to the left
                children: [
                  Text(
                    MyStrings.welcomeScreenTitleTxt,
                    style: TextStyle(
                      fontSize: 20.spMin,
                      color: AppColors.secondaryColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 0.01.sh),
                  Padding(
                    padding: EdgeInsets.only(bottom: 0.07.sh),
                    child: Text(
                      MyStrings.welcomeScreenSubtitleTxt,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 16.spMin,
                        color: AppColors.welcomeScreenSubtitleColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 0.08.sw),
                    child: PrimaryButton(
                      label: MyStrings.welcomeButtonTxt,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AuthenticationScreen(),
                          ),
                        );
                      },
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
