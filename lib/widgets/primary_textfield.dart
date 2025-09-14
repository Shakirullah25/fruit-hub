import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fruit_salad_combo/constant/colors.dart';

class PrimaryTextField extends StatelessWidget {
  final String? hintText;
  final Widget? icon;
  final TextEditingController? textEditingController;
  final TextInputType? keyboardType;
  final void Function(String)? onChanged;
  final String? errorText;

  const PrimaryTextField({
    super.key,
    this.hintText,
    this.icon,
    this.textEditingController,
    this.keyboardType,
    this.onChanged,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    final outLineInputBorder = OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.textFieldColor),
      borderRadius: BorderRadius.all(Radius.circular(10)).r,
    );

    return TextFormField(
      onChanged: onChanged,
      keyboardType: keyboardType,
      controller: textEditingController,
      style: TextStyle(fontSize: 16.spMin),
      cursorColor: AppColors.primaryColor,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: AppColors.hintTxtColor,
          fontSize: 16.spMin,
        ),
        prefixIcon: icon,
        fillColor: AppColors.textFieldColor,
        filled: true,
        contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 12.w),
        enabledBorder: outLineInputBorder,
        focusedBorder: outLineInputBorder,
        errorText: errorText,
        errorStyle: TextStyle(
          fontSize: 12.spMin,
          color: AppColors.primaryColor,
        ),
      ),
    );
  }
}







// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:fruit_salad_combo/constant/colors.dart';

// class PrimaryTextField extends StatelessWidget {
//   final String? hintText;
//   final Widget? icon;
//   final TextEditingController? textEditingController;
//   final TextInputType? keyboardType;
//   final void Function(String)? onChanged;
//   const PrimaryTextField({
//     super.key,
//     this.hintText,
//     this.icon,
//     this.textEditingController,
//     this.keyboardType,
//     this.onChanged,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final outLineInputBorder = OutlineInputBorder(
//       borderSide: BorderSide(color: AppColors.textFieldColor),
//       borderRadius: BorderRadius.all(Radius.circular(10)).r,
//     );
//     return SizedBox(
//       height: 0.08.sh,
//       child: TextField(
        
//         onChanged: onChanged,
//         keyboardType: keyboardType,
//         controller: textEditingController,
//         style: TextStyle(fontSize: 16.spMin),
//         showCursor: true,
//         cursorColor: AppColors.primaryColor,
//         decoration: InputDecoration(
//           hintText: hintText,
//           hintStyle: TextStyle(
//             //fontFamily:,
//             color: AppColors.hintTxtColor,
//             fontSize: 16.spMin,
//           ),
//           prefixIcon: icon,
//           fillColor: AppColors.textFieldColor,
//           filled: true,
//           contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 12.w),
//           enabledBorder: outLineInputBorder,
//           focusedBorder: outLineInputBorder,
//         ),
//       ),
//     );
//   }
// }

// // import 'package:flutter/material.dart';
// // import 'package:flutter_screenutil/flutter_screenutil.dart';
// // import 'package:fruit_salad_combo/constant/colors.dart';
// // import 'package:fruit_salad_combo/constant/my_strings.dart';

// // Padding textfield(OutlineInputBorder outLineInputBorder) {
// //   return Padding(
// //     padding: EdgeInsets.only(left: 0.1.sw, right: 0.1.sw, bottom: 0.07.sh),
// //     child: SizedBox(
// //       height: 0.08.sh,
// //       child: TextField(
// //         style: TextStyle(fontSize: 16.spMin),
// //         showCursor: true,
// //         cursorColor: AppColors.primaryColor,
// //         decoration: InputDecoration(
// //           hintText: MyStrings.hintTxt,
// //           hintStyle: TextStyle(
// //             color: AppColors.hintTxtColor,
// //             fontSize: 16.spMin,
// //           ),
// //           fillColor: AppColors.textFieldColor,
// //           filled: true,
// //           contentPadding: EdgeInsets.symmetric(
// //             vertical: 16.h,
// //             horizontal: 12.w,
// //           ).r,
// //           enabledBorder: outLineInputBorder,
// //           focusedBorder: outLineInputBorder,
// //         ),
// //       ),
// //     ),
// //   );
// // }
