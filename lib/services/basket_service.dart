import 'package:flutter/cupertino.dart';

class BasketItem {
  final String img;
  final String fruitName;
  final String fruitQty;
  final String fruitPrize;
  final String comboId; // To identify unique combos

  BasketItem({
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
    return other is BasketItem && other.comboId == comboId;
  }

  @override
  int get hashCode => comboId.hashCode;
}

class BasketService {
  static final List<BasketItem> _basketItems = [];

  static ValueNotifier<int> itemCount = ValueNotifier<int>(0);

  static List<BasketItem> get basketItems => List.unmodifiable(_basketItems);

  static void addItem(BasketItem item) {
    // Check if item already exists, if so update quantity and price
    final existingIndex = _basketItems.indexWhere(
      (existing) => existing.comboId == item.comboId,
    );

    if (existingIndex != -1) {
      // Update existing item
      _basketItems[existingIndex] = item;
    } else {
      // Add new item
      _basketItems.add(item);
    }

    // Update Notifier
    itemCount.value = _basketItems.length;
  }

  static void removeItem(String comboId) {
    _basketItems.removeWhere((item) => item.comboId == comboId);

    // Update Notifier
    itemCount.value = _basketItems.length;
  }

  static void clearBasket() {
    _basketItems.clear();

    // Update Notifier
    itemCount.value = 0;
  }

  static double getTotalAmount() {
    double total = 0.0;
    for (var item in _basketItems) {
      String priceStr = item.fruitPrize.replaceAll(RegExp(r'[^\d.]'), '');
      double price = double.tryParse(priceStr) ?? 0.0;
      total += price;
    }
    return total;
  }

  static int get count => _basketItems.length;

  static bool get isEmpty => _basketItems.isEmpty;

  static void persistOrder(String address, String phoneNumber) {
    // In a real app, this would send data to backend
    // For now, just clear the basket after "persisting"
    clearBasket();
  }
}
