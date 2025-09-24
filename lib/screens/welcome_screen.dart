import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fruit_salad_combo/constant/colors.dart';
import 'package:fruit_salad_combo/constant/my_strings.dart';
import 'package:fruit_salad_combo/screens/authentication_screen.dart';
import 'package:fruit_salad_combo/widgets/primary_button.dart';
import 'package:fruit_salad_combo/widgets/container.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  void _navigateToAuth() {
    EasyLoading.show(status: "Loading...");

    Future.delayed(const Duration(seconds: 1), () {
      EasyLoading.dismiss();
      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AuthenticationScreen()),
        );
      }
    });
  }

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
                      key: const Key(MyStrings.letsContinue),
                      label: MyStrings.letsContinue,
                      onPressed: () => _navigateToAuth(),
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
