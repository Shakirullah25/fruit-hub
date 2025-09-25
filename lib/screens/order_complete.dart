import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fruit_salad_combo/constant/colors.dart';
import 'package:fruit_salad_combo/constant/my_strings.dart';
import 'package:fruit_salad_combo/screens/main_screen.dart';
import 'package:fruit_salad_combo/screens/track_order.dart';
import 'package:fruit_salad_combo/widgets/primary_button.dart';

class OrderComplete extends StatelessWidget {
  final String userName;

  const OrderComplete({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.scaffoldColor,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(MyStrings.orderComplete),
              30.verticalSpace,
              Text(
                MyStrings.congrats,
                style: TextStyle(
                  fontSize: 32.spMin,
                  fontWeight: FontWeight.w500,
                  color: AppColors.secondaryColor,
                ),
              ),
              SizedBox(height: 0.02.sh),
              Text(
                textAlign: TextAlign.center,
                MyStrings.congratsOrderMsg,
                style: TextStyle(
                  fontSize: 20.spMin,
                  fontWeight: FontWeight.w400,
                  color: AppColors.secondaryColor,
                ),
              ),
              SizedBox(height: 0.06.sh),
              PrimaryButton(
                label: MyStrings.trackOrder,
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const TrackOrder()),
                ),
                width: 0.4.sw,
              ),
              SizedBox(height: 0.06.sh),
              PrimaryButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) =>
                          MainScreen(userName: userName),
                    ),
                  );
                },
                width: 0.6.sw,
                label: MyStrings.continueShopping,
                backgroundColor: AppColors.scaffoldColor,
                foregroundColor: AppColors.primaryColor,
                borderSide: BorderSide(color: AppColors.primaryColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
