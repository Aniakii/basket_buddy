import 'package:basket_buddy/data/models/product.dart';
import 'package:basket_buddy/data/repositories/basket_buddy_database.dart';
import 'package:flutter/material.dart';
import 'package:basket_buddy/data/models/unit_enum.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddItemScreen extends StatefulWidget {
  static const id = "add_item_screen";

  @override
  _AddItemScreenState createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  String selectedProductName = "";
  double quantity = 0.0;
  UnitEnum selectedUnit = UnitEnum.pieces;

  String quantityErrorText = "";

  List<Product> products = [];

  List<UnitEnum> units = [
    UnitEnum.pieces,
    UnitEnum.kilogram,
    UnitEnum.gram,
    UnitEnum.liters,
    UnitEnum.meters,
  ];

  @override
  Widget build(BuildContext context) {
    final basketBuddyDatabase =
        RepositoryProvider.of<BasketBuddyDataBase>(context);
    products = basketBuddyDatabase.products;
    selectedProductName = selectedProductName.isNotEmpty
        ? selectedProductName
        : products.first.name;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Shopping List Item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DropdownButtonFormField<String>(
              value: selectedProductName,
              onChanged: (value) {
                setState(() {
                  selectedProductName = value!;
                });
              },
              items: products.map((product) {
                return DropdownMenuItem<String>(
                  value: product.name,
                  child: Text(product.name),
                );
              }).toList(),
              decoration: const InputDecoration(
                labelText: 'Product Name',
              ),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  if ((double.tryParse(value) ?? 0.0) > 0.0) {
                    quantity = double.tryParse(value) ?? 0.0;
                    quantityErrorText = "";
                  } else {
                    quantityErrorText = "Quantity has to be greater than zero.";
                  }
                });
              },
              decoration: const InputDecoration(
                labelText: 'Quantity',
              ),
            ),
            Text(
              quantityErrorText,
              style: const TextStyle(color: Colors.red),
            ),
            const SizedBox(height: 16.0),
            DropdownButtonFormField<UnitEnum>(
              value: selectedUnit,
              onChanged: (value) {
                setState(() {
                  selectedUnit = value!;
                });
              },
              items: units.map((unit) {
                return DropdownMenuItem<UnitEnum>(
                  value: unit,
                  child: Text(unit.toString().split('.').last),
                );
              }).toList(),
              decoration: const InputDecoration(
                labelText: 'Unit',
              ),
            ),
            const SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: () {
                if (quantity <= 0.0) {
                  return;
                }
                int productId = products
                    .where((element) => element.name == selectedProductName)
                    .first
                    .id;
                final itemObject = {
                  "productId": productId,
                  "quantity": quantity,
                  "unit": selectedUnit,
                };
                Navigator.of(context).pop(itemObject);
              },
              child: const Text('Add Item'),
            ),
          ],
        ),
      ),
    );
  }
}
