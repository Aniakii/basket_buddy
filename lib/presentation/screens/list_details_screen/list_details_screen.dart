import 'package:basket_buddy/data/models/product.dart';
import 'package:basket_buddy/data/models/shopping_list.dart';
import 'package:basket_buddy/data/models/shopping_list_item.dart';
import 'package:basket_buddy/data/models/unit_enum.dart';
import 'package:basket_buddy/data/repositories/basket_buddy_database.dart';
import 'package:basket_buddy/presentation/screens/add_item_screen/add_item_screen.dart';
import 'package:basket_buddy/presentation/screens/all_lists_screen/bloc/all_lists_bloc.dart';
import 'package:basket_buddy/presentation/screens/all_lists_screen/bloc/all_lists_event.dart';
import 'package:basket_buddy/presentation/screens/all_lists_screen/bloc/all_lists_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListDetailsScreen extends StatefulWidget {
  static const id = "list_details_screen";
  final ShoppingList shoppingList;

  const ListDetailsScreen({super.key, required this.shoppingList});

  @override
  State<ListDetailsScreen> createState() => _ListDetailsScreenState();
}

class _ListDetailsScreenState extends State<ListDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final basketBuddyDatabase =
        RepositoryProvider.of<BasketBuddyDataBase>(context);
    List<Product> allProducts = basketBuddyDatabase.products;

    return BlocBuilder<AllListsBloc, AllListsState>(
        builder: (BuildContext context, AllListsState state) {
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.shoppingList.name),
        ),
        body: 
        widget.shoppingList.items.isEmpty ?
        const Text("It seems that you haven't added any products yet. Click the + button to add a product.")
        : ListView.builder(
          itemCount: widget.shoppingList.items.length,
          itemBuilder: (BuildContext context, int index) {
            final ShoppingListItem item = widget.shoppingList.items[index];
            return ListTile(
              leading: Checkbox(
                value: item.isBought,
                onChanged: (bool? newValue) {
                  setState(() {
                    item.isBought = newValue ?? false;
                  });
                },
              ),
              title: Text(
                allProducts
                    .firstWhere((product) => product.id == item.productId)
                    .name,
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
                  setState(() {
                    context
                        .read<AllListsBloc>()
                        .add(DeleteItemEvent(item, widget.shoppingList.id));
                  });
                },
              ),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final result = await Navigator.of(context)
                .pushNamed(AddItemScreen.id) as Map<String, dynamic>?;
            if (result != null) {
              int id = 0;
              if (widget.shoppingList.items.isNotEmpty) {
                id = widget.shoppingList.items
                        .map((e) => e.id)
                        .reduce((curr, next) => curr > next ? curr : next) +
                    1;
              }
              ShoppingListItem newItem = ShoppingListItem(
                  id: id,
                  productId: result["productId"],
                  quantity: result["quantity"],
                  unit: result["unit"],
                  isBought: false);

              context
                  .read<AllListsBloc>()
                  .add(AddItemEvent(newItem, widget.shoppingList.id));
            }
          },
          child: const Icon(Icons.add),
        ),
      );
    });
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
