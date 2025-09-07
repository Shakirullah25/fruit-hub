// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:fruit_salad_combo/widgets/primary_button.dart';
// import 'package:fruit_salad_combo/constant/colors.dart';
// import 'package:fruit_salad_combo/widgets/container.dart';
// import 'package:fruit_salad_combo/constant/my_strings.dart';
// import 'package:fruit_salad_combo/widgets/primary_textfield.dart';

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: AppColors.scaffoldColor,
//         //appBar: AppBar(backgroundColor: AppColors.primaryColor),
//         body: Column(
//           children: [
//             FruitBasketContainer(basketImgPath: "", shadowImgPath: "",),
//             SizedBox(height: 0.05.sh),
//             Padding(
//               padding: EdgeInsets.only(left: 0.1.sw, bottom: 0.03.sh),
//               child: Align(
//                 alignment: Alignment.centerLeft,
//                 child: Text(
//                   MyStrings.firstName,
//                   style: TextStyle(
//                     fontSize: 20.spMin,
//                     fontWeight: FontWeight.w500,
//                     color: AppColors.secondaryColor,
//                   ),
//                 ),
//               ),
//             ),
//             PrimaryTextField(),
//             PrimaryButton(onPressed: () {}, label: '',),
//           ],
//         ),
//       ),
//     );
//   }
// }
