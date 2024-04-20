import 'package:basket_buddy/data/models/product.dart';
import 'package:basket_buddy/data/repositories/basket_buddy_database.dart';
import 'package:dropdownfield2/dropdownfield2.dart';
import 'package:flutter/material.dart';
import 'package:basket_buddy/data/models/unit_enum.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddItemScreen extends StatefulWidget {
  const AddItemScreen({super.key});

  static const id = "add_item_screen";

  @override
  State<AddItemScreen> createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  final TextEditingController _productController = TextEditingController();

  @override
  void dispose() {
    _productController.dispose();
    super.dispose();
  }

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
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          reverse: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              DropDownField(
                controller: _productController,
                value: selectedProductName,
                labelText: "Product",
                itemsVisibleInDropdown: 5,
                labelStyle: const TextStyle(
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                  fontSize: 16.0,
                ),
                enabled: true,
                items: products.map((product) {
                  return product.name;
                }).toList(),
                onValueChanged: (value) {
                  setState(() {
                    selectedProductName = value;
                  });
                },
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 3.0),
                child: Container(color: Colors.black, height: 1.25),
              ),
              // DropdownButtonFormField<String>(
              //   value: selectedProductName,
              //   onChanged: (value) {
              //     setState(() {
              //       selectedProductName = value!;
              //     });
              //   },
              //   items: products.map((product) {
              //     return DropdownMenuItem<String>(
              //       value: product.name,
              //       child: Text(product.name),
              //     );
              //   }).toList(),
              //   decoration: const InputDecoration(
              //     labelText: 'Product Name',
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    setState(() {
                      if ((double.tryParse(value) ?? 0.0) > 0.0) {
                        quantity = double.tryParse(value) ?? 0.0;
                        quantityErrorText = "";
                      } else {
                        quantityErrorText =
                            "Quantity has to be greater than zero.";
                      }
                    });
                  },
                  decoration: const InputDecoration(
                    labelText: 'Quantity',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  quantityErrorText,
                  style: const TextStyle(color: Colors.red),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButtonFormField<UnitEnum>(
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
                  decoration: const InputDecoration(labelText: 'Unit'),
                ),
              ),

              const SizedBox(height: 10.0),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
