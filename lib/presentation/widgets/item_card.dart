import 'package:basket_buddy/data/models/shopping_list_item.dart';
import 'package:basket_buddy/data/models/unit_enum.dart';
import 'package:flutter/material.dart';

class ItemCard extends StatelessWidget {
  const ItemCard({super.key, required this.item, required this.productName, required this.deleteFunction, required this.checkboxFunction});

  final ShoppingListItem item;
  final String productName;
  final Null Function() checkboxFunction;
  final Function deleteFunction;

  @override
  Widget build(BuildContext context) {
    return ListTile(
              leading: Checkbox(
                value: item.isBought,
                onChanged: checkboxFunction(),
              ),
              title: Text(
                productName,
                style: TextStyle(
                  decoration: item.isBought
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                ),
              ),
              subtitle: Text('${item.quantity} ${_getUnitLabel(item.unit)}'),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  deleteFunction();
                },
              ),
            );
  }

    String _getUnitLabel(UnitEnum unit) {
    switch (unit) {
      case UnitEnum.pieces:
        return 'pcs';
      case UnitEnum.kilogram:
        return 'kg';
      case UnitEnum.gram:
        return 'g';
      case UnitEnum.liters:
        return 'l';
      case UnitEnum.meters:
        return 'm';
      default:
        return '';
    }
  }
  
}