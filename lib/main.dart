import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fruit_salad_combo/config_loading.dart';
import 'package:fruit_salad_combo/constant/colors.dart';
import 'package:fruit_salad_combo/screens/splash_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(statusBarColor: AppColors.primaryColor),
  );
  runApp(MyApp());
  configLoading();
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
        builder: (context, child) => AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle(statusBarColor: AppColors.primaryColor),
          child: EasyLoading.init()(context, child),
        ),
        debugShowCheckedModeBanner: false,
        title: "Fruit Hub",
        theme: ThemeData(
          appBarTheme: AppBarTheme(systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: AppColors.primaryColor, statusBarIconBrightness: Brightness.light, statusBarBrightness: Brightness.dark),),
          textTheme: GoogleFonts.poppinsTextTheme(),
          useMaterial3: true,
          primaryColor: AppColors.primaryColor,
        ),
        home: child,
      );
    },
    child: SplashScreen(),
  );
}
