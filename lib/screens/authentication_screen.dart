import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fruit_salad_combo/screens/main_screen.dart';
import 'package:fruit_salad_combo/widgets/primary_button.dart';
import 'package:fruit_salad_combo/constant/colors.dart';
import 'package:fruit_salad_combo/widgets/container.dart';
import 'package:fruit_salad_combo/constant/my_strings.dart';
import 'package:fruit_salad_combo/widgets/primary_textfield.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({super.key});

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  String? _errorMessage;

  @override
  void dispose() {
    _firstNameController;
    super.dispose();
  }

  void _authenticate() {
    final String name = _firstNameController.text.trim();

    // Reset error message

    setState(() {
      _errorMessage = null;
    });

    if (name.isEmpty) {
      setState(() {
        _errorMessage = "Name cannot be empty.";
      });
    } else if (name.length > 25) {
      setState(() {
        _errorMessage = "Name is too long.";
      });
    } else if (!RegExp(r"^[a-zA-Z\s]+$").hasMatch(name)) {
      setState(() {
        _errorMessage = "Please use only letters and spaces.";
      });
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MainScreen()),
      );
    }
  }
  
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
            SizedBox(height: 0.05.sh),
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
                    child: PrimaryTextField(
                      hintText: MyStrings.authHintTxt,
                      textEditingController: _firstNameController,
                      keyboardType: TextInputType.name,
                      errorText: _errorMessage,
                    ),
                  ),
                  SizedBox(height: 0.05.sh),
                  Padding(
                    padding: EdgeInsets.only(right: 0.08.sw),
                    child: PrimaryButton(
                      label: MyStrings.authButtonTxt,
                      onPressed: () => _authenticate(),
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
