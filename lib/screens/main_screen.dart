import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fruit_salad_combo/constant/colors.dart';
import 'package:fruit_salad_combo/constant/my_strings.dart';
import 'package:fruit_salad_combo/data/combo_data.dart';
import 'package:fruit_salad_combo/model/combo_details.dart';
import 'package:fruit_salad_combo/screens/add_to_basket_screen.dart';
import 'package:fruit_salad_combo/screens/order_list.dart';
import 'package:fruit_salad_combo/screens/wish_list.dart';
import 'package:fruit_salad_combo/services/basket_service.dart';
import 'package:fruit_salad_combo/services/wishlist_service.dart';
import 'package:fruit_salad_combo/widgets/primary_textfield.dart';
import 'package:fruit_salad_combo/widgets/recommended_combo_widget.dart';
import 'package:badges/badges.dart' as badges;

class MainScreen extends StatefulWidget {
  final String userName;
  const MainScreen({super.key, required this.userName});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

enum SortOption { nameAZ, nameZA, priceLowHigh, priceHighLow }

class _MainScreenState extends State<MainScreen> {
  late List<ComboDetails> recommendedCombos;
  late List<ComboDetails> hottestCombos;
  late List<ComboDetails> popularCombos;
  late List<ComboDetails> newCombos;
  late List<ComboDetails> topCombos;
  late TextEditingController _searchController;
  String _searchQuery = '';
  bool _isSearching = false;
  SortOption _currentSort = SortOption.nameAZ;

  @override
  void initState() {
    super.initState();
    recommendedCombos = ComboData.getRecommendedCombos();
    hottestCombos = ComboData.getHottestCombos();
    popularCombos = ComboData.getPopularCombos();
    newCombos = ComboData.getNewCombos();
    topCombos = ComboData.getTopCombos();
    _sortCombos(recommendedCombos);
    _sortCombos(hottestCombos);
    _sortCombos(popularCombos);
    _sortCombos(newCombos);
    _sortCombos(topCombos);
    _searchController = TextEditingController();
    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text.toLowerCase();
        if (_searchQuery.isNotEmpty) {
          _isSearching = true;
          Future.delayed(const Duration(milliseconds: 500), () {
            if (mounted) setState(() => _isSearching = false);
          });
        } else {
          _isSearching = false;
        }
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  int _parsePrice(String price) {
    // Remove # and spaces, parse to int
    return int.tryParse(
          price.replaceAll('#', '').replaceAll(' ', '').replaceAll(',', ''),
        ) ??
        0;
  }

  void _sortCombos(List<ComboDetails> combos) {
    combos.sort((a, b) {
      switch (_currentSort) {
        case SortOption.nameAZ:
          return a.fruitName.compareTo(b.fruitName);
        case SortOption.nameZA:
          return b.fruitName.compareTo(a.fruitName);
        case SortOption.priceLowHigh:
          return _parsePrice(a.fruitPrice).compareTo(_parsePrice(b.fruitPrice));
        case SortOption.priceHighLow:
          return _parsePrice(b.fruitPrice).compareTo(_parsePrice(a.fruitPrice));
      }
    });
  }

  List<ComboDetails> _getFilteredCombos() {
    if (_searchQuery.isEmpty) return [];
    List<ComboDetails> allCombos = [
      ...recommendedCombos,
      ...hottestCombos,
      ...popularCombos,
      ...newCombos,
      ...topCombos,
    ];
    List<ComboDetails> filtered = allCombos
        .where((combo) => combo.fruitName.toLowerCase().contains(_searchQuery))
        .toList();
    _sortCombos(filtered);
    return filtered;
  }

  void _navigateToAddToBasket(ComboDetails combo) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddToBasketScreen(comboDetails: combo),
      ),
    );
  }

  void _addToWishlist(ComboDetails combo) {
    final wishlistItem = WishlistItem(
      img: combo.imgPath,
      fruitName: combo.fruitName,
      fruitQty: '1', // Default quantity
      fruitPrize: combo.fruitPrice,
      comboId: "${combo.imgPath}_${combo.fruitName}",
    );
    bool added = WishlistService.addItem(wishlistItem);
    if (added) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          showCloseIcon: true,
          closeIconColor: AppColors.scaffoldColor,
          backgroundColor: AppColors.primaryColor,

          content: Text(
            'Item added to wishlist',
            style: TextStyle(
              fontSize: 16.spMin,
              color: AppColors.scaffoldColor,
            ),
          ),
          duration: const Duration(seconds: 2),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          showCloseIcon: true,
          closeIconColor: AppColors.scaffoldColor,
          backgroundColor: AppColors.primaryColor,
          content: Text(
            'Already added to wishlist',
            style: TextStyle(
              fontSize: 16.spMin,
              color: AppColors.scaffoldColor,
            ),
          ),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final displayedName = widget.userName.length > 15
        ? '${widget.userName.substring(0, 15)}...'
        : widget.userName;

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.scaffoldColor,
        appBar: AppBar(
          backgroundColor: AppColors.scaffoldColor,
          foregroundColor: AppColors.primaryColor,
          leading: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const WishList()),
              );
            },
            icon: Icon(
              Icons.favorite_border,
              // size: 0.06.sw,
              color: AppColors.primaryColor,
            ),
          ),
          actions: [
            ValueListenableBuilder<int>(
              valueListenable: BasketService.itemCount,
              builder: (context, count, child) {
                return IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const OrderList(),
                      ),
                    );
                  },
                  icon: badges.Badge(
                    showBadge: true,
                    position: badges.BadgePosition.topEnd(top: 0, end: 0),
                    badgeStyle: badges.BadgeStyle(
                      //padding: EdgeInsets.all(6),
                    ),
                    // If there are items, show count. If not, show a small dot
                    badgeContent: count > 0
                        ? Text(
                            count.toString(),
                            style: TextStyle(
                              color: AppColors.scaffoldColor,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        : null,
                    child: Image.asset(
                      MyStrings.myBasketImg,
                      width: 0.1.sw,
                      height: 0.1.sh,
                    ),
                  ),
                );
              },
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
                            text:
                                '${MyStrings.homeGreetings1.replaceAll('Tony', '')}$displayedName, ',
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
                  25.verticalSpace,
                  //SizedBox(height: 0.03.sh),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: PrimaryTextField(
                          hintText: MyStrings.hintTxt,
                          icon: Icon(
                            Icons.search,
                            color: AppColors.hintTxtColor,
                          ),
                          textEditingController: _searchController,
                          // icon: Image.asset(
                          //   MyStrings.searchIcon,
                          //   width: 0.1.sw,
                          //   height: 0.1.sh,
                          // ),
                        ),
                      ),
                      SizedBox(width: 0.015.sw),
                      SizedBox(
                        //height: 0.1.sh, // 👈 match TextField height
                        width: 0.1.sw,
                        child: PopupMenuButton<SortOption>(
                          color: AppColors.textFieldColor,
                          padding: EdgeInsets.zero,
                          icon: Icon(
                            Icons.tune_outlined,
                            color: AppColors.secondaryColor,
                          ),
                          onSelected: (SortOption value) {
                            setState(() {
                              _currentSort = value;
                              _sortCombos(recommendedCombos);
                              _sortCombos(hottestCombos);
                              _sortCombos(popularCombos);
                              _sortCombos(newCombos);
                              _sortCombos(topCombos);
                            });
                          },
                          itemBuilder: (BuildContext context) =>
                              <PopupMenuEntry<SortOption>>[
                                PopupMenuItem<SortOption>(
                                  value: SortOption.nameAZ,
                                  child: Text(
                                    MyStrings.sortByNameAZ,
                                    style: TextStyle(
                                      fontSize: 16.spMin,
                                      color: AppColors.secondaryColor,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                                PopupMenuItem<SortOption>(
                                  value: SortOption.nameZA,
                                  child: Text(
                                    MyStrings.sortByNameZA,
                                    style: TextStyle(
                                      fontSize: 16.spMin,
                                      color: AppColors.secondaryColor,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                                PopupMenuItem<SortOption>(
                                  value: SortOption.priceLowHigh,
                                  child: Text(
                                    MyStrings.sortByPriceLowHigh,
                                    style: TextStyle(
                                      fontSize: 16.spMin,
                                      color: AppColors.secondaryColor,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                                PopupMenuItem<SortOption>(
                                  value: SortOption.priceHighLow,
                                  child: Text(
                                    MyStrings.sortByPriceHighLow,
                                    style: TextStyle(
                                      fontSize: 16.spMin,
                                      color: AppColors.secondaryColor,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ],
                        ),
                      ),
                    ],
                  ),
                  if (_searchQuery.isNotEmpty) ...[
                    25.verticalSpace,
                    if (_isSearching) ...[
                      Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ] else ...[
                      if (_getFilteredCombos().isEmpty) ...[
                        Center(
                          child: Text(
                            'No results found. Try a different search term.',
                            style: TextStyle(
                              fontSize: 16.spMin,
                              color: AppColors.secondaryColor,
                              fontWeight: FontWeight.w400,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ] else ...[
                        Text(
                          'Search Results',
                          style: TextStyle(
                            fontSize: 24.spMax,
                            color: AppColors.secondaryColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 0.02.sh),
                        SizedBox(
                          height: 0.25.sh,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: _getFilteredCombos()
                                  .map(
                                    (combo) => Padding(
                                      padding: EdgeInsets.only(right: 0.04.sw),
                                      child: SizedBox(
                                        width: 0.4.sw,
                                        child: RecommendedComboWidget(
                                          comboImgPath: combo.imgPath,
                                          comboName: combo.fruitName,
                                          comboPrize: combo.fruitPrice,
                                          onPressed: () =>
                                              _addToWishlist(combo),
                                          onTap: () =>
                                              _navigateToAddToBasket(combo),
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                        ),
                      ],
                    ],
                  ] else ...[
                    25.verticalSpace,
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
                    SizedBox(
                      height: 0.25.sh,
                      child: Stack(
                        alignment: Alignment.centerRight,
                        children: [
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                ...recommendedCombos.map(
                                  (combo) => Padding(
                                    padding: EdgeInsets.only(right: 0.04.sw),
                                    child: SizedBox(
                                      width: 0.4.sw,
                                      child: RecommendedComboWidget(
                                        comboImgPath: combo.imgPath,
                                        comboName: combo.fruitName,
                                        comboPrize: combo.fruitPrice,
                                        onPressed: () => _addToWishlist(combo),
                                        onTap: () =>
                                            _navigateToAddToBasket(combo),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 0.07.sw,
                            height: 0.19.sh,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.addContainerColor,
                            ),
                            alignment: Alignment.center,
                            child: Icon(
                              Icons.arrow_forward_ios,
                              color: AppColors.primaryColor,
                              size: 18.sp,
                            ),
                          ),
                        ],
                      ),
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
                          // Hottest
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 16.0,
                              right: 16,
                              top: 16,
                              bottom: 16,
                            ),
                            child: SizedBox(
                              height: 0.25.sh,
                              child: Stack(
                                alignment: Alignment.centerRight,
                                children: [
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: [
                                        ...hottestCombos.asMap().entries.map((
                                          entry,
                                        ) {
                                          int index = entry.key;
                                          ComboDetails combo = entry.value;
                                          Color? color;
                                          if (index == 0)
                                            color =
                                                AppColors.quinoContainerColor;
                                          else if (index == 1)
                                            color = AppColors
                                                .tropicalContainerColor;
                                          else if (index == 2)
                                            color = AppColors.tabComboColor;
                                          return Padding(
                                            padding: EdgeInsets.only(
                                              right: 0.04.sw,
                                            ),
                                            child: SizedBox(
                                              width: 0.4.sw,
                                              child: RecommendedComboWidget(
                                                comboImgPath: combo.imgPath,
                                                comboName: combo.fruitName,
                                                comboPrize: combo.fruitPrice,
                                                onPressed: () =>
                                                    _addToWishlist(combo),
                                                onTap: () =>
                                                    _navigateToAddToBasket(
                                                      combo,
                                                    ),
                                                color: color,
                                              ),
                                            ),
                                          );
                                        }),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: 0.07.sw,
                                    height: 0.19.sh,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColors.scaffoldColor,
                                    ),
                                    alignment: Alignment.center,
                                    child: Icon(
                                      Icons.arrow_forward_ios,
                                      color: AppColors.primaryColor,
                                      size: 18.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // Popular
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 16.0,
                              right: 16,
                              top: 16,
                              bottom: 16,
                            ),
                            child: SizedBox(
                              height: 0.25.sh,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    ...popularCombos.asMap().entries.map((
                                      entry,
                                    ) {
                                      int index = entry.key;
                                      ComboDetails combo = entry.value;
                                      Color? color;
                                      if (index == 0)
                                        color = AppColors.tabComboColor;
                                      if (index == 1)
                                        color = AppColors.tabComboColor;
                                      return Padding(
                                        padding: EdgeInsets.only(
                                          right: 0.04.sw,
                                        ),
                                        child: SizedBox(
                                          width: 0.4.sw,
                                          child: RecommendedComboWidget(
                                            comboImgPath: combo.imgPath,
                                            comboName: combo.fruitName,
                                            comboPrize: combo.fruitPrice,
                                            onPressed: () =>
                                                _addToWishlist(combo),
                                            onTap: () =>
                                                _navigateToAddToBasket(combo),
                                            color: color,
                                          ),
                                        ),
                                      );
                                    }),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          // New combo
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 16.0,
                              right: 16,
                              top: 16,
                              bottom: 16,
                            ),
                            child: SizedBox(
                              height: 0.25.sh,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    ...newCombos.asMap().entries.map((entry) {
                                      int index = entry.key;
                                      ComboDetails combo = entry.value;
                                      Color? color;
                                      if (index == 0)
                                        color = AppColors.quinoContainerColor;
                                      if (index == 1)
                                        color = AppColors.quinoContainerColor;
                                      return Padding(
                                        padding: EdgeInsets.only(
                                          right: 0.04.sw,
                                        ),
                                        child: SizedBox(
                                          width: 0.4.sw,
                                          child: RecommendedComboWidget(
                                            comboImgPath: combo.imgPath,
                                            comboName: combo.fruitName,
                                            comboPrize: combo.fruitPrice,
                                            onPressed: () =>
                                                _addToWishlist(combo),
                                            onTap: () =>
                                                _navigateToAddToBasket(combo),
                                            color: color,
                                          ),
                                        ),
                                      );
                                    }),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          // Top
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 16.0,
                              right: 16,
                              top: 16,
                              bottom: 16,
                            ),
                            child: SizedBox(
                              height: 0.25.sh,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    ...topCombos.asMap().entries.map((entries) {
                                      int index = entries.key;
                                      ComboDetails combo = entries.value;
                                      Color? color;
                                      if (index == 0)
                                        color = AppColors.addContainerColor;
                                      if (index == 1)
                                        color = AppColors.addContainerColor;
                                      return Padding(
                                        padding: EdgeInsets.only(
                                          right: 0.04.sw,
                                        ),
                                        child: SizedBox(
                                          width: 0.4.sw,
                                          child: RecommendedComboWidget(
                                            comboImgPath: combo.imgPath,
                                            comboName: combo.fruitName,
                                            comboPrize: combo.fruitPrice,
                                            onPressed: () =>
                                                _addToWishlist(combo),
                                            onTap: () =>
                                                _navigateToAddToBasket(combo),
                                            color: color,
                                          ),
                                        ),
                                      );
                                    }),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
