import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fruit_salad_combo/constant/colors.dart';

class PrimaryButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String label;
  final double? height;
  final double? width;

  PrimaryButton({
    super.key,
    this.onPressed,
    required this.label,
    double? height,
    double? width,
  }) : height = height ?? 0.065.sh, // 👈 moved here
       width = width ?? double.infinity;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10).r, // match TextField
          ),
          backgroundColor: AppColors.primaryColor,
          foregroundColor: AppColors.buttonTxtColor,
          padding: EdgeInsets.symmetric(vertical: 12.h),
        ),
        child: Text(
          label,
          style: TextStyle(fontSize: 16.spMin, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}



// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:fruit_salad_combo/constant/colors.dart';
// import 'package:fruit_salad_combo/constant/my_strings.dart';
// import 'package:google_fonts/google_fonts.dart';

// class PrimaryButton extends StatelessWidget {
  // final VoidCallback? onPressed;
  // final String label;

//   const PrimaryButton({Key? key, this.onPressed, this.label = MyStrings.buttonTxt}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.only(left: 0.1.sw, right: 0.1.sw),
//       child: SizedBox(
//         width: double.infinity,
//         height: 0.065.sh,
//         child: ElevatedButton(
//           onPressed: onPressed,
//           style: ElevatedButton.styleFrom(
//             elevation: 0,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(10).r,
//             ),
//             backgroundColor: AppColors.primaryColor,
//             foregroundColor: AppColors.buttonTxtColor,
//             padding: EdgeInsets.symmetric(vertical: 12.h),
//           ),
//           child: Text(
//             label,
//             style: GoogleFonts.darkerGrotesque(
//               fontSize: 16.spMin,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//         ),
//       ),
//     );