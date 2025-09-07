import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fruit_salad_combo/constant/colors.dart';
import 'package:fruit_salad_combo/constant/my_strings.dart';
import 'package:fruit_salad_combo/widgets/primary_textfield.dart';
import 'package:fruit_salad_combo/widgets/recommended_combo_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.scaffoldColor,
        appBar: AppBar(
          backgroundColor: AppColors.scaffoldColor,
          foregroundColor: AppColors.primaryColor,
          leading: IconButton(
            onPressed: () {},
            icon: Image.asset(
              MyStrings.navImg,
              width: 0.1.sw,
              height: 0.1.sh,
              //fit: BoxFit.contain,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Image.asset(
                MyStrings.myBasketImg,
                width: 0.1.sw,
                height: 0.1.sh,
                //fit: BoxFit.contain,
              ),
            ),
          ],
        ),
        body: DefaultTabController(
          length: 4,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: 20.spMin,
                          color: AppColors.secondaryColor,
                        ),
                        children: [
                          TextSpan(
                            text: MyStrings.homeGreetings1,
                            style: TextStyle(fontWeight: FontWeight.w400),
                          ),
                          TextSpan(
                            text: MyStrings.homeGreetings2,
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 0.03.sh),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: PrimaryTextField(
                          hintText: MyStrings.hintTxt,
                          icon: Image.asset(
                            MyStrings.searchIcon,
                            width: 0.1.sw,
                            height: 0.1.sh,
                          ),
                        ),
                      ),
                      SizedBox(width: 0.015.sw),
                      SizedBox(
                        height: 0.1.sh, // 👈 match TextField height
                        width: 0.1.sw,
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {},
                          icon: Image.asset(MyStrings.sortIcon),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 0.04.sh),
                  Text(
                    //textAlign: TextAlign.start,
                    MyStrings.recommendedComboTxt,
                    style: TextStyle(
                      fontSize: 24.spMax,
                      color: AppColors.secondaryColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 0.04.sh),
                  Row(
                    children: [
                      Expanded(
                        child: RecommendedComboWidget(
                          comboImgPath: MyStrings.honeyLimeComboImg,
                          comboName: MyStrings.honeyLimeComboTxt,
                          comboPrize: MyStrings.honeycomboPrize,
                          onPressed: () {},
                          onTap: () {},
                        ),
                      ),
                      SizedBox(width: 0.04.sw),
                      Expanded(
                        child: RecommendedComboWidget(
                          comboImgPath: MyStrings.glowingBerryImg,
                          comboName: MyStrings.glowingBerry,
                          comboPrize: MyStrings.glowingBerryPrize,
                          onPressed: () {},
                          onTap: () {},
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 0.04.sh),

                  // TAB BAR
                  TabBar(
                    indicator: UnderlineTabIndicator(
                      borderSide: BorderSide(
                        width: 3.0,
                        color: AppColors.primaryColor,
                      ),
                      insets: EdgeInsets.symmetric(
                        horizontal: 25.0,
                      ), // 👈 shrink indicator
                    ),
                    tabAlignment: TabAlignment.start,
                    dividerHeight: 0,
                    indicatorSize: TabBarIndicatorSize.label,
                    labelColor: AppColors.secondaryColor,
                    labelStyle: TextStyle(
                      fontSize: 24.spMin,
                      fontWeight: FontWeight.w500,
                    ),
                    indicatorColor: AppColors.primaryColor,
                    unselectedLabelColor: AppColors.hintTxtColor,
                    unselectedLabelStyle: TextStyle(
                      fontSize: 16.spMin,
                      fontWeight: FontWeight.w500,
                    ),
                    isScrollable: true,
                    tabs: [
                      Tab(text: MyStrings.tab1),
                      Tab(text: MyStrings.tab2),
                      Tab(text: MyStrings.tab3),
                      Tab(text: MyStrings.tab4),
                    ],
                  ),

                  // TABBARVIEW with fixed height instead of Expanded
                  SizedBox(
                    height: 0.3.sh, // Fixed height for TabBarView content
                    child: TabBarView(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 16.0,
                            right: 16,
                            top: 16,
                            bottom: 16,
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: RecommendedComboWidget(
                                  comboImgPath: MyStrings.quinoaImg,
                                  comboName: MyStrings.quinoFruit,
                                  comboPrize: MyStrings.hottestComboPrize,
                                  onPressed: () {},
                                  onTap: () {},
                                  color: AppColors.quinoContainerColor,
                                ),
                              ),
                              SizedBox(width: 0.04.sw),
                              Expanded(
                                child: RecommendedComboWidget(
                                  comboImgPath: MyStrings.tropicalFruitImg,
                                  comboName: MyStrings.tropicalFruit,
                                  comboPrize: MyStrings.hottestComboPrize,
                                  onPressed: () {},
                                  onTap: () {},
                                  color: AppColors.tropicalContainerColor,
                                ),
                              ),
                              // SizedBox(width: 0.04.sw),

                              // Expanded(
                              //   child: RecommendedComboWidget(
                              //     comboImgPath: MyStrings.tropicalFruitImg,
                              //     comboName: MyStrings.tropicalFruit,
                              //     comboPrize: MyStrings.hottestComboPrize,
                              //     onPressed: () {},
                              //     onTap: () {},
                              //     color: AppColors.tropicalContainerColor,
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                        Center(child: Text("Tab 2 content")),
                        Center(child: Text("Tab 3 content")),
                        Center(child: Text("Tab 4 content")),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
