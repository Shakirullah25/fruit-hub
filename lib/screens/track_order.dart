import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fruit_salad_combo/model/delivery_agent_location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:fruit_salad_combo/constant/colors.dart';
import 'package:fruit_salad_combo/constant/my_strings.dart';
import 'package:fruit_salad_combo/model/delivery_status.dart';

// Your backend-ready data model. In a real app, this would come from a server.

class TrackOrder extends StatefulWidget {
  const TrackOrder({super.key});

  @override
  State<TrackOrder> createState() => _TrackOrderState();
}

class _TrackOrderState extends State<TrackOrder> {
  // Mock backend data. In a real app, this would be fetched from a server.
  final Map<String, dynamic> mockBackendData = {
    'latitude': 6.5244,
    'longitude': 3.3792,
    'isDelivered': false,
  };

  late DeliveryAgentLocation _deliveryAgentLocation;
  late GoogleMapController _mapController;
  final Set<Marker> _markers = {};

  // A method to update the marker's position on the map.
  void _updateMarker() {
    setState(() {
      _markers.clear();
      // Show the marker only if the delivery is NOT completed.
      if (!_deliveryAgentLocation.isDelivered) {
        final LatLng _deliveryAgentLatLng = LatLng(
          _deliveryAgentLocation.latitude,
          _deliveryAgentLocation.longitude,
        );
        _markers.add(
          Marker(
            markerId: const MarkerId("Delivery Agent"),
            position: _deliveryAgentLatLng,
            infoWindow: const InfoWindow(title: "Delivery Agent Location"),
          ),
        );
      }
    });
  }

  // Initial camera position for the map.
  static const CameraPosition _initialCameraPosition = CameraPosition(
    target: LatLng(6.5244, 3.3792), // Lagos, Nigeria
    zoom: 12,
  );

  @override
  void initState() {
    super.initState();
    // Simulate fetching data from the backend.
    _deliveryAgentLocation = DeliveryAgentLocation.fromJson(mockBackendData);
    _updateMarker();
  }

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
        icon: Image.asset(MyStrings.orderReceipt),
      ),
      DeliveryStatus(
        title: "Order Is Being Prepared",
        isCompleted: true,
        icon: Image.asset(MyStrings.orderPrepared),
      ),
      DeliveryStatus(
        title: "Order Is Being Delivered",
        description: "Your delivery agent is coming",
        isCompleted: false,
        icon: Image.asset(MyStrings.orderDelivered),
      ),
    ];

    // Create a complete list of all items, including the map and final step.
    final List<Widget> timelineItems = [];

    // Add the regular delivery status steps.
    for (int i = 0; i < mockSteps.length; i++) {
      final step = mockSteps[i];
      final colors =
          deliveryContainerColors[i % deliveryContainerColors.length];
      timelineItems.add(
        Column(
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
                  child: FittedBox(fit: BoxFit.contain, child: step.icon),
                ),
                10.horizontalSpace,
                Expanded(
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            step.title,
                            style: TextStyle(
                              fontSize: 16.spMin,
                              fontWeight: FontWeight.w500,
                              color: AppColors.secondaryColor,
                            ),
                          ),
                          if (step.description != null)
                            Text(
                              step.description!,
                              style: TextStyle(
                                fontSize: 16.spMin,
                                fontWeight: FontWeight.w400,
                                color: AppColors.secondaryColor,
                              ),
                            ),
                        ],
                      ),
                      const Spacer(),
                      if (i == mockSteps.length - 1)
                        Image.asset(
                          MyStrings.telephoneImg,
                          width: 40.w,
                          height: 40.h,
                        )
                      else
                        Icon(
                          step.isCompleted
                              ? Icons.check_circle
                              : Icons.radio_button_unchecked,
                          color: step.isCompleted
                              ? Colors.green
                              : AppColors.secondaryColor.withAlpha(1),
                          size: 20.spMin,
                        ),
                    ],
                  ),
                ),
              ],
            ),
            // Dotted line after each step to the next one
            Padding(
              padding: EdgeInsets.only(left: 32.5.w),
              child: SizedBox(
                height: 22.h,
                child: DottedLine(
                  direction: Axis.vertical,
                  lineLength: 22.h,
                  lineThickness: 1.5,
                  dashColor: AppColors.primaryColor,
                  dashLength: 2,
                  dashGapLength: 4,
                ),
              ),
            ),
          ],
        ),
      );
    }

    // Add the map step
    timelineItems.add(
      Container(
        height: 0.15.sh,
        width: double.infinity,
        //margin: EdgeInsets.only(left: 20.w),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.r)),
        clipBehavior: Clip.hardEdge,
        child: GoogleMap(
          zoomControlsEnabled: false,
          rotateGesturesEnabled: false,
          zoomGesturesEnabled: false,
          mapToolbarEnabled: false,
          myLocationEnabled: true,
          mapType: MapType.normal,
          initialCameraPosition: _initialCameraPosition,
          onMapCreated: (GoogleMapController controller) {
            _mapController = controller;
          },
          markers: _markers,
        ),
      ),
    );

    // Add the dotted line from the map to the final step
    timelineItems.add(
      Padding(
        padding: EdgeInsets.only(left: 32.5.w),
        child: SizedBox(
          height: 32.5.h,
          child: DottedLine(
            direction: Axis.vertical,
            lineLength: 32.5.h,
            lineThickness: 1.5,
            dashColor: AppColors.primaryColor,
            dashLength: 2,
            dashGapLength: 4,
          ),
        ),
      ),
    );

    // Add the final 'Order Received' step as shown in the image
    timelineItems.add(
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 65.w,
            height: 65.h,
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: AppColors.lightGreen,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: FittedBox(
              fit: BoxFit.contain,
              child: Image.asset(MyStrings.orderRecievedImg),
              // child: Icon(
              //   Icons.check,
              //   color: AppColors.scaffoldColor,
              //   size: 40,
              // ),
            ),
          ),
          10.horizontalSpace,
          Text(
            MyStrings.orderRecieved,
            style: TextStyle(
              fontSize: 16.spMin,
              fontWeight: FontWeight.w500,
              color: AppColors.secondaryColor,
            ),
          ),
          const Spacer(),
          // New: The status indicator (three circles)
          Row(
            children: [
              // First dot
              Container(
                width: 8.w,
                height: 8.w,
                decoration: BoxDecoration(
                  color: AppColors.tropicalContainerColor,
                  shape: BoxShape.circle,
                ),
              ),
              5.horizontalSpace,

              // Second dot
              Container(
                width: 8.w,
                height: 8.w,
                decoration: BoxDecoration(
                  color: AppColors.quinoContainerColor.withValues(alpha: 1),
                  shape: BoxShape.circle,
                ),
              ),
              5.horizontalSpace,

              // Third dot
              Container(
                width: 8.w,
                height: 8.w,
                decoration: BoxDecoration(
                  color: AppColors.quinoContainerColor.withValues(alpha: 1),
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
        ],
      ),
    );

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.scaffoldColor,
        appBar: AppBar(
          toolbarHeight: 100,
          backgroundColor: AppColors.primaryColor,
          automaticallyImplyLeading: false,
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
          child: ListView(children: timelineItems),
        ),
      ),
    );
  }
}
