import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fruit_salad_combo/constant/colors.dart';
import 'package:fruit_salad_combo/screens/track_order.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => ScreenUtilInit(
    designSize: Size(405, 844),
    splitScreenMode: true,
    minTextAdapt: true,
    builder: (_, child) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Fruit Hub",
        theme: ThemeData(
          textTheme: GoogleFonts.robotoTextTheme(),
          useMaterial3: true,
          primaryColor: AppColors.primaryColor,
        ),
        home: child,
      );
    },
    child: TrackOrder(),
  );
}
