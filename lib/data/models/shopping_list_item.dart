import 'package:basket_buddy/data/models/unit_enum.dart';

import 'Product.dart';

class ShoppingListItem {
  final int id;
  final Product product;
  final int productId;
  final int quantity;
  final UnitEnum unit;
  bool isBought = false;

  ShoppingListItem({required this.id, required this.product, required this.productId, required this.quantity, required this.unit});
}