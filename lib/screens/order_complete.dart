import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fruit_salad_combo/constant/colors.dart';
import 'package:fruit_salad_combo/constant/my_strings.dart';
import 'package:fruit_salad_combo/screens/track_order.dart';
import 'package:fruit_salad_combo/screens/main_screen.dart';
import 'package:fruit_salad_combo/widgets/primary_button.dart';

class OrderComplete extends StatefulWidget {
  final String userName;
  const OrderComplete({super.key, required this.userName});

  @override
  State<OrderComplete> createState() => _OrderCompleteState();
}

class _OrderCompleteState extends State<OrderComplete> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _isLoading = true;
  }

  void _trackOrder() {
    EasyLoading.show(status: "Loading...");

    Future.delayed(Duration(seconds: 2), () {
      EasyLoading.dismiss();
      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => TrackOrder()),
        );
      }
    });
  }

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
                onPressed: () {
                  _trackOrder();
                },
                width: 0.4.sw,
              ),
              SizedBox(height: 0.06.sh),
              PrimaryButton(
                onPressed: () {
                  // Navigate back to the main screen and clear the previous stack
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (_) => MainScreen(userName: widget.userName),
                    ),
                    (route) => false,
                  );
                },
                width: 0.6.sw,
                label: MyStrings.continueShopping, // 👈 give this a diff label
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
