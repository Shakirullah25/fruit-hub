import 'package:flutter/material.dart';
import 'package:fruit_salad_combo/colors.dart';
import 'package:fruit_salad_combo/my_strings.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final outLineInputBorder = OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.textFieldColor),
      borderRadius: BorderRadius.all(Radius.circular(16)),
    );
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      //appBar: AppBar(backgroundColor: AppColors.primaryColor),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              child: Container(
                width: double.infinity,
                height: size.height * 0.5,
                color: AppColors.primaryColor,
                child: Align(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        MyStrings.basketImgPath,
                        // width: size.width,
                        // height: size.height,
                        fit: BoxFit.contain,
                      ),

                      Image.asset(
                        MyStrings.shadowImgPath,
                        // width: size.width,
                        // height: size.height,
                        fit: BoxFit.contain,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30, left: 50, right: 50),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                MyStrings.firstName,
                style: GoogleFonts.darkerGrotesque(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.firstNameColor,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 50, right: 50),
            child: TextField(
              
              showCursor: true,
              decoration: InputDecoration(
                hintText: "",
                fillColor: AppColors.textFieldColor,
                filled: true,
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 10,
                ),
                enabledBorder: outLineInputBorder,
                focusedBorder: outLineInputBorder,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
