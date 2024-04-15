import 'package:basket_buddy/data/models/unit_enum.dart';

class ShoppingListItem {
  final int id;
  final int productId;
  final double quantity;
  final UnitEnum unit;
  bool isBought = false;

  ShoppingListItem(
      {required this.id,
      required this.productId,
      required this.quantity,
      required this.unit,
      required this.isBought});
}
