import 'package:flutter/material.dart';
import 'package:fruit_salad_combo/colors.dart';
import 'package:fruit_salad_combo/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Fruit Salad Combo",
      theme: ThemeData(
        primaryColor: AppColors.primaryColor,
      ),
      home: const HomeScreen(),
    );
  }
}
