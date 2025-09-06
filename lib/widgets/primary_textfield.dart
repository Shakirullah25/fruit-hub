import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fruit_salad_combo/constant/colors.dart';
import 'package:fruit_salad_combo/constant/my_strings.dart';

class PrimaryTextField extends StatelessWidget {
  const PrimaryTextField({super.key});

  @override
  Widget build(BuildContext context) {
    final outLineInputBorder = OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.textFieldColor),
      borderRadius: BorderRadius.all(Radius.circular(10)).r,
    );
    return SizedBox(
      height: 0.08.sh,
      child: TextField(
        style: TextStyle(fontSize: 16.spMin),
        showCursor: true,
        cursorColor: AppColors.primaryColor,
        decoration: InputDecoration(
          hintText: MyStrings.hintTxt,
          hintStyle: TextStyle(
            color: AppColors.hintTxtColor,
            fontSize: 16.spMin,
          ),
          fillColor: AppColors.textFieldColor,
          filled: true,
          contentPadding: EdgeInsets.symmetric(
            vertical: 16.h,
            horizontal: 12.w,
          ).r,
          enabledBorder: outLineInputBorder,
          focusedBorder: outLineInputBorder,
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:fruit_salad_combo/constant/colors.dart';
// import 'package:fruit_salad_combo/constant/my_strings.dart';

// Padding textfield(OutlineInputBorder outLineInputBorder) {
//   return Padding(
//     padding: EdgeInsets.only(left: 0.1.sw, right: 0.1.sw, bottom: 0.07.sh),
//     child: SizedBox(
//       height: 0.08.sh,
//       child: TextField(
//         style: TextStyle(fontSize: 16.spMin),
//         showCursor: true,
//         cursorColor: AppColors.primaryColor,
//         decoration: InputDecoration(
//           hintText: MyStrings.hintTxt,
//           hintStyle: TextStyle(
//             color: AppColors.hintTxtColor,
//             fontSize: 16.spMin,
//           ),
//           fillColor: AppColors.textFieldColor,
//           filled: true,
//           contentPadding: EdgeInsets.symmetric(
//             vertical: 16.h,
//             horizontal: 12.w,
//           ).r,
//           enabledBorder: outLineInputBorder,
//           focusedBorder: outLineInputBorder,
//         ),
//       ),
//     ),
//   );
// }
