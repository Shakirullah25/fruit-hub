import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fruit_salad_combo/constant/colors.dart';
import 'package:fruit_salad_combo/constant/my_strings.dart';
import 'package:fruit_salad_combo/model/delivery_status.dart';

class TrackOrder extends StatelessWidget {
  TrackOrder({super.key});

  final List<Color> deliveryContainerColors = [
    AppColors.quinoContainerColor,
    AppColors.tropicalContainerColor,
    AppColors.glowingBerryColor,
  ];

  @override
  Widget build(BuildContext context) {
    final List<DeliveryStatus> mockSteps = [
      DeliveryStatus(
        title: "Order Taken",
        isCompleted: true,
        icon: Image.asset(
          MyStrings.orderReceipt,
          width: 0.01.sw,
          height: 0.01.sh,
        ),
      ),
      DeliveryStatus(
        title: "Order Is Being Prepared",
        isCompleted: true,
        icon: Image.asset(
          MyStrings.orderPrepared,
          width: 0.01.sw,
          height: 0.01.sh,
        ),
      ),
      DeliveryStatus(
        title: "Order Is Being Delivered",
        description: "Your delivery agent is coming",
        isCompleted: false,
        icon: Image.asset(
          MyStrings.orderDelivered,
          width: 0.01.sw,
          height: 0.01.sh,
        ),
      ),
    ];

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.scaffoldColor,
        appBar: AppBar(
          toolbarHeight: 150,
          backgroundColor: AppColors.primaryColor,
          automaticallyImplyLeading: false, // removes default back
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ElevatedButton.icon(
                onPressed: () {},
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: AppColors.secondaryColor,
                  size: 18.spMin,
                ),
                label: Text(
                  MyStrings.goBack,
                  style: TextStyle(
                    fontSize: 14.spMin,
                    fontWeight: FontWeight.w400,
                    color: AppColors.secondaryColor,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.scaffoldColor,
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 6.h,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.r),
                  ),
                ),
              ),
              SizedBox(width: 0.1.sw),
              Text(
                MyStrings.deliveryStatus,
                style: TextStyle(
                  fontSize: 24.spMin,
                  fontWeight: FontWeight.w500,
                  color: AppColors.scaffoldColor,
                ),
              ),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(25.0),
          child: ListView.builder(
            itemCount: mockSteps.length,
            itemBuilder: (context, index) {
              final steps = mockSteps[index];
              final colors =
                  deliveryContainerColors[index %
                      deliveryContainerColors.length];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 65.w,
                        height: 65.h,
                        padding: EdgeInsets.all(10.w),
                        decoration: BoxDecoration(
                          color: colors,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: steps.icon,
                      ),
                      10.horizontalSpace,
                      Expanded(
                        child: Row(
                          children: [
                            Text(
                              steps.title,
                              style: TextStyle(
                                fontSize: 16.spMin,
                                fontWeight: FontWeight.w500,
                                color: AppColors.secondaryColor,
                              ),
                            ),
                            const Spacer(),
                            Icon(
                              steps.isCompleted
                                  ? Icons.check_circle
                                  : Icons.radio_button_unchecked,
                              color: steps.isCompleted
                                  ? Colors.green
                                  : AppColors.secondaryColor.withAlpha(1),
                              size: 20.spMin,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  if (index != mockSteps.length - 1)
                    Padding(
                      padding: EdgeInsets.only(
                        left: 32.5.w,
                      ), // Adjust to center the line
                      child: SizedBox(
                        height: 65.h,
                        child: DottedLine(
                          direction: Axis.vertical,
                          lineLength: 65.h,
                          lineThickness: 2,
                          dashColor: AppColors.primaryColor,
                          dashLength: 6,
                          dashGapLength: 4,
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
