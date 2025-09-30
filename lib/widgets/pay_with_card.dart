import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fruit_salad_combo/constant/colors.dart';
import 'package:fruit_salad_combo/constant/my_strings.dart';
import 'package:fruit_salad_combo/screens/order_complete.dart';
import 'package:fruit_salad_combo/services/basket_service.dart';
import 'package:fruit_salad_combo/utils/validators.dart';

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

class PayWithCardSheet extends StatefulWidget {
  final String userName;
  
  const PayWithCardSheet({super.key, required this.userName});

  @override
  State<PayWithCardSheet> createState() => _PayWithCardSheetState();
}

class _PayWithCardSheetState extends State<PayWithCardSheet> {
  final TextEditingController cardHolderController = TextEditingController();
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController expiryDateController = TextEditingController();
  final TextEditingController cvvController = TextEditingController();
  
  String? cardHolderError;
  String? cardNumberError;
  String? expiryDateError;
  String? cvvError;
  
  bool isProcessing = false;

  @override
  void dispose() {
    cardHolderController.dispose();
    cardNumberController.dispose();
    expiryDateController.dispose();
    cvvController.dispose();
    super.dispose();
  }

  void _formatCardNumber(String value) {
    // Remove all non-digits
    String digitsOnly = value.replaceAll(RegExp(r'\D'), '');
    
    // Add spaces every 4 digits
    String formatted = '';
    for (int i = 0; i < digitsOnly.length; i++) {
      if (i > 0 && i % 4 == 0) {
        formatted += ' ';
      }
      formatted += digitsOnly[i];
    }
    
    // Update controller if different
    if (formatted != cardNumberController.text) {
      cardNumberController.value = TextEditingValue(
        text: formatted,
        selection: TextSelection.collapsed(offset: formatted.length),
      );
    }
  }

  void _formatExpiryDate(String value) {
    // Remove all non-digits
    String digitsOnly = value.replaceAll(RegExp(r'\D'), '');
    
    // Add slash after 2 digits
    String formatted = '';
    for (int i = 0; i < digitsOnly.length && i < 4; i++) {
      if (i == 2) {
        formatted += '/';
      }
      formatted += digitsOnly[i];
    }
    
    // Update controller if different
    if (formatted != expiryDateController.text) {
      expiryDateController.value = TextEditingValue(
        text: formatted,
        selection: TextSelection.collapsed(offset: formatted.length),
      );
    }
  }

  void _handleCompleteOrder() async {
    if (isProcessing) return;

    final cardHolder = cardHolderController.text.trim();
    final cardNumber = cardNumberController.text.trim();
    final expiryDate = expiryDateController.text.trim();
    final cvv = cvvController.text.trim();

    final cardHolderValidationError = validateCardHolderName(cardHolder);
    final cardNumberValidationError = validateCardNumber(cardNumber);
    final expiryDateValidationError = validateExpiryDate(expiryDate);
    final cvvValidationError = validateCVV(cvv);

    setState(() {
      cardHolderError = cardHolderValidationError;
      cardNumberError = cardNumberValidationError;
      expiryDateError = expiryDateValidationError;
      cvvError = cvvValidationError;
    });

    if (cardHolderValidationError != null ||
        cardNumberValidationError != null ||
        expiryDateValidationError != null ||
        cvvValidationError != null) {
      return;
    }

    setState(() {
      isProcessing = true;
    });

    EasyLoading.show(status: "Processing payment...");

    try {
      // Simulate payment processing
      await Future.delayed(const Duration(seconds: 3));

      // Simulate payment success (you can add actual payment logic here)
      BasketService.persistOrder("Card Payment", cardNumber.replaceAll(RegExp(r'\d(?=\d{4})'), '*'));

      EasyLoading.dismiss();

      if (mounted) {
        Navigator.pop(context); // Close the sheet
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OrderComplete(userName: widget.userName),
          ),
        );
      }
    } catch (e) {
      EasyLoading.dismiss();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Payment failed. Please try again."),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          isProcessing = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
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
                15.verticalSpace,
                TextFormField(
                  controller: cardHolderController,
                  textCapitalization: TextCapitalization.words,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z\s\-\.\']")),
                    LengthLimitingTextInputFormatter(50),
                  ],
                  style: TextStyle(fontSize: 16.spMin),
                  cursorColor: AppColors.primaryColor,
                  decoration: InputDecoration(
                    hintText: MyStrings.cardHolderHintName,
                    hintStyle: TextStyle(
                      color: AppColors.hintTxtColor,
                      fontSize: 16.spMin,
                    ),
                    fillColor: AppColors.textFieldColor,
                    filled: true,
                    contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 12.w),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.textFieldColor),
                      borderRadius: BorderRadius.all(Radius.circular(10)).r,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.textFieldColor),
                      borderRadius: BorderRadius.all(Radius.circular(10)).r,
                    ),
                    errorText: cardHolderError,
                    errorStyle: TextStyle(
                      fontSize: 12.spMin,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  onChanged: (value) {
                    if (cardHolderError != null) {
                      setState(() {
                        cardHolderError = null;
                      });
                    }
                  },
                ),
                15.verticalSpace,
                _buildTextWidget(title: MyStrings.cardNumber),
                15.verticalSpace,
                TextFormField(
                  controller: cardNumberController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(19), // 16 digits + 3 spaces
                  ],
                  style: TextStyle(fontSize: 16.spMin),
                  cursorColor: AppColors.primaryColor,
                  decoration: InputDecoration(
                    hintText: MyStrings.cardNumberHint,
                    hintStyle: TextStyle(
                      color: AppColors.hintTxtColor,
                      fontSize: 16.spMin,
                    ),
                    fillColor: AppColors.textFieldColor,
                    filled: true,
                    contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 12.w),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.textFieldColor),
                      borderRadius: BorderRadius.all(Radius.circular(10)).r,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.textFieldColor),
                      borderRadius: BorderRadius.all(Radius.circular(10)).r,
                    ),
                    errorText: cardNumberError,
                    errorStyle: TextStyle(
                      fontSize: 12.spMin,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  onChanged: (value) {
                    _formatCardNumber(value);
                    if (cardNumberError != null) {
                      setState(() {
                        cardNumberError = null;
                      });
                    }
                  },
                ),
                15.verticalSpace,
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildTextWidget(title: MyStrings.date),
                          10.verticalSpace,
                          TextFormField(
                            controller: expiryDateController,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(5), // MM/YY
                            ],
                            style: TextStyle(fontSize: 16.spMin),
                            cursorColor: AppColors.primaryColor,
                            decoration: InputDecoration(
                              hintText: MyStrings.dateHint,
                              hintStyle: TextStyle(
                                color: AppColors.hintTxtColor,
                                fontSize: 16.spMin,
                              ),
                              fillColor: AppColors.textFieldColor,
                              filled: true,
                              contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 12.w),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: AppColors.textFieldColor),
                                borderRadius: BorderRadius.all(Radius.circular(10)).r,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: AppColors.textFieldColor),
                                borderRadius: BorderRadius.all(Radius.circular(10)).r,
                              ),
                              errorText: expiryDateError,
                              errorStyle: TextStyle(
                                fontSize: 12.spMin,
                                color: AppColors.primaryColor,
                              ),
                            ),
                            onChanged: (value) {
                              _formatExpiryDate(value);
                              if (expiryDateError != null) {
                                setState(() {
                                  expiryDateError = null;
                                });
                              }
                            },
                          ),
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
                          10.verticalSpace,
                          TextFormField(
                            controller: cvvController,
                            keyboardType: TextInputType.number,
                            obscureText: true,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(4),
                            ],
                            style: TextStyle(fontSize: 16.spMin),
                            cursorColor: AppColors.primaryColor,
                            decoration: InputDecoration(
                              hintText: MyStrings.ccvHint,
                              hintStyle: TextStyle(
                                color: AppColors.hintTxtColor,
                                fontSize: 16.spMin,
                              ),
                              fillColor: AppColors.textFieldColor,
                              filled: true,
                              contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 12.w),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: AppColors.textFieldColor),
                                borderRadius: BorderRadius.all(Radius.circular(10)).r,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: AppColors.textFieldColor),
                                borderRadius: BorderRadius.all(Radius.circular(10)).r,
                              ),
                              errorText: cvvError,
                              errorStyle: TextStyle(
                                fontSize: 12.spMin,
                                color: AppColors.primaryColor,
                              ),
                            ),
                            onChanged: (value) {
                              if (cvvError != null) {
                                setState(() {
                                  cvvError = null;
                                });
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          20.verticalSpace,
          GestureDetector(
            onTap: isProcessing ? null : _handleCompleteOrder,
            child: SizedBox(
              width: double.infinity,
              height: 0.1.sh,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: isProcessing 
                      ? AppColors.primaryColor.withValues(alpha: 0.6)
                      : AppColors.primaryColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16.r),
                    topRight: Radius.circular(16.r),
                  ),
                ),
                child: Center(
                  child: SizedBox(
                    width: 160.w,
                    height: 50.h,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: AppColors.scaffoldColor,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Center(
                        child: isProcessing
                            ? SizedBox(
                                width: 20.w,
                                height: 20.w,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    AppColors.primaryColor,
                                  ),
                                ),
                              )
                            : _buildTextWidget(
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
        ],
      ),
    );
  }
}

// Function to show the 'Pay with Card' sheet.
void showPayWithCardSheet(BuildContext context, String userName) {
  showModalBottomSheet(
    context: context,
    backgroundColor: AppColors.scaffoldColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
    ),
    isScrollControlled: true,
    isDismissible: false, // Prevent dismissing during processing
    enableDrag: false, // Prevent dragging during processing
    builder: (context) => PayWithCardSheet(userName: userName),
  );
}