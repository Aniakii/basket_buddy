import 'dart:core';

import 'package:basket_buddy/data/models/shopping_list_item.dart';

class ShoppingList {
  final int id;
  final String name;
  List<ShoppingListItem> items = [];
  final String color;
  final String emoji;
  bool isActive = true;
  final int owner;

  ShoppingList(
      {required this.id,
      required this.name,
      required this.color,
      required this.emoji,
      required this.owner});

  bool canBeDeleted() {
    if (items.isEmpty) {
      return true;
    }
    return !items.any((final element) => !element.isBought);
  }
}
