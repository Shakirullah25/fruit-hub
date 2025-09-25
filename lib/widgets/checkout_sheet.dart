import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fruit_salad_combo/constant/colors.dart';
import 'package:fruit_salad_combo/constant/my_strings.dart';
import 'package:fruit_salad_combo/screens/order_complete.dart';
import 'package:fruit_salad_combo/services/basket_service.dart';
import 'package:fruit_salad_combo/utils/validators.dart';
import 'package:fruit_salad_combo/widgets/pay_with_card.dart';
import 'package:fruit_salad_combo/widgets/primary_button.dart';
import 'package:fruit_salad_combo/widgets/primary_textfield.dart';

Widget _buildTextWidget({required String title}) {
  return Text(
    title,
    style: TextStyle(
      fontSize: 20.spMin,
      fontWeight: FontWeight.w500,
      color: AppColors.secondaryColor,
    ),
  );
}

class CheckoutSheet extends StatefulWidget {
  const CheckoutSheet({super.key});

  @override
  State<CheckoutSheet> createState() => _CheckoutSheetState();
}

class _CheckoutSheetState extends State<CheckoutSheet> {
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  String? addressError; // flag for address error
  String? phoneError; // flag for phone error

  @override
  void dispose() {
    addressController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  void _handlePayOnDelivery() async {
    final address = addressController.text.trim();
    final phone = phoneController.text.trim();

    final addressValidationError = validateAddress(address);
    final phoneValidationError = validatePhoneNumber(phone);

    setState(() {
      addressError = addressValidationError;
      phoneError = phoneValidationError;
    });

    if (addressValidationError != null || phoneValidationError != null) {
      return;
    }

    EasyLoading.show(status: "Processing order...");

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    BasketService.persistOrder(address, phone);

    EasyLoading.dismiss();

    if (mounted) {
      Navigator.pop(context); // Close the sheet
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const OrderComplete()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.only(
              top: 0.04.sh,
              left: 0.06.sw,
              right: 0.06.sw,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTextWidget(title: MyStrings.deliveryAddress),
                15.verticalSpace,
                PrimaryTextField(
                  textEditingController: addressController,
                  hintText: MyStrings.hintDeliveryAddress,
                  errorText: addressError,
                  onChanged: (value) {
                    if (addressError != null) {
                      setState(() {
                        addressError = null;
                      });
                    }
                  },
                ),
                15.verticalSpace,
                _buildTextWidget(title: MyStrings.no2Call),
                15.verticalSpace,
                PrimaryTextField(
                  textEditingController: phoneController,
                  hintText: MyStrings.numberHint,
                  errorText: phoneError,
                  onChanged: (value) {
                    if (phoneError != null) {
                      setState(() {
                        phoneError = null;
                      });
                    }
                  },
                ),
                25.verticalSpace,
                Row(
                  children: [
                    Expanded(
                      child: PrimaryButton(
                        label: MyStrings.payOnDelivery,
                        backgroundColor: AppColors.scaffoldColor,
                        foregroundColor: AppColors.primaryColor,
                        onPressed: _handlePayOnDelivery,
                        borderSide: BorderSide(color: AppColors.primaryColor),
                      ),
                    ),
                    SizedBox(width: 0.05.sw), // space between buttons
                    Expanded(
                      child: PrimaryButton(
                        onPressed: () => showPayWithCardSheet(context),
                        label: MyStrings.payWithCard,
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
        ),
        // -----> Top Close Icon in a Stack Widget <-----
        Positioned(
          top: -0.07.sh, // negative to make it float outside sheet
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
}

void showCheckoutSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    backgroundColor: AppColors.scaffoldColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
    ),
    isScrollControlled: true,
    builder: (context) => const CheckoutSheet(),
  );
}
