import 'package:flutter/cupertino.dart';

class WishlistItem {
  final String img;
  final String fruitName;
  final String fruitQty;
  final String fruitPrize;
  final String comboId; // To identify unique combos

  WishlistItem({
    required this.img,
    required this.fruitName,
    required this.fruitQty,
    required this.fruitPrize,
    required this.comboId,
  });

  Map<String, dynamic> toMap() {
    return {
      "img": img,
      "fruitName": fruitName,
      "fruitQty": fruitQty,
      "fruitPrize": fruitPrize,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is WishlistItem && other.comboId == comboId;
  }

  @override
  int get hashCode => comboId.hashCode;
}

class WishlistService {
  static final List<WishlistItem> _wishlistItems = [];

  static ValueNotifier<int> itemCount = ValueNotifier<int>(0);

  static List<WishlistItem> get wishlistItems => List.unmodifiable(_wishlistItems);

  static bool addItem(WishlistItem item) {
    // Check if item already exists, if so do nothing (no duplicates)
    final existingIndex = _wishlistItems.indexWhere(
      (existing) => existing.comboId == item.comboId,
    );

    if (existingIndex == -1) {
      // Add new item
      _wishlistItems.add(item);
      // Update Notifier
      itemCount.value = _wishlistItems.length;
      return true;
    }
    return false;
  }

  static void removeItem(String comboId) {
    _wishlistItems.removeWhere((item) => item.comboId == comboId);

    // Update Notifier
    itemCount.value = _wishlistItems.length;
  }

  static void clearWishlist() {
    _wishlistItems.clear();

    // Update Notifier
    itemCount.value = 0;
  }

  static bool isInWishlist(String comboId) {
    return _wishlistItems.any((item) => item.comboId == comboId);
  }

  static int get count => _wishlistItems.length;

  static bool get isEmpty => _wishlistItems.isEmpty;
}