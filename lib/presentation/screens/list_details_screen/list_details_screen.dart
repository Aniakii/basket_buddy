import 'package:basket_buddy/constants/categories_icons.dart';
import 'package:basket_buddy/constants/list_decorations.dart';
import 'package:basket_buddy/data/models/category.dart';
import 'package:basket_buddy/data/models/product.dart';
import 'package:basket_buddy/data/models/shopping_list_item.dart';
import 'package:basket_buddy/data/models/unit_enum.dart';
import 'package:basket_buddy/data/repositories/basket_buddy_database.dart';
import 'package:basket_buddy/presentation/screens/add_item_screen/add_item_screen.dart';
import 'package:basket_buddy/presentation/screens/list_details_screen/bloc/list_details_event.dart';
import 'package:basket_buddy/presentation/screens/list_details_screen/bloc/list_details_state.dart';
import 'package:basket_buddy/presentation/screens/list_details_screen/bloc/list_details_bloc.dart';
import 'package:basket_buddy/constants/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListDetailsScreen extends StatefulWidget {
  static const id = "list_details_screen";

  const ListDetailsScreen({super.key});

  @override
  State<ListDetailsScreen> createState() => _ListDetailsScreenState();
}

class _ListDetailsScreenState extends State<ListDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final BasketBuddyDataBase database = context.read<BasketBuddyDataBase>();
    final List<Product> allProducts = database.products;
    final List<Category> allCategories = database.categories;

    return BlocBuilder<ListDetailsBloc, ListDetailsState>(
        builder: (BuildContext context, ListDetailsState state) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            '${listEmojis[state.shoppingList!.emoji]} ${state.shoppingList!.name}',
          ),
          backgroundColor: listColors[state.shoppingList!.color] != Colors.white
              ? listColors[state.shoppingList!.color]
              : Colors.deepPurple,
        ),
        body: state.status == ListDetailsStatus.empty
            ? const Padding(
                padding: EdgeInsets.all(15.0),
                child: Text(
                  "It seems that you haven't added any products yet. Click the + button to add a product.",
                  style: TextStyle(fontSize: 25.0),
                ))
            : state.status == ListDetailsStatus.error
                ? const Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Text(
                      "Somehing went wrong :( Try again later",
                      style: TextStyle(fontSize: 25.0),
                    ))
                : ListView.builder(
                    itemCount: state.shoppingList!.items.length,
                    itemBuilder: (BuildContext context, int index) {
                      final ShoppingListItem item =
                          state.shoppingList!.items[index];
                      final Product product = allProducts.firstWhere(
                          (element) => element.id == item.productId);

                      final String? categoryEmoji = categoriesIcons[
                          allCategories
                              .firstWhere(
                                  (element) => element.id == product.categoryId)
                              .name];
                      return ListTile(
                        leading: Checkbox(
                          value: item.isBought,
                          onChanged: (bool? newValue) {
                            setState(() {
                              context
                                  .read<ListDetailsBloc>()
                                  .add(ModifyItemEvent(item));
                            });
                          },
                        ),
                        title: Text(
                          '${product.name} $categoryEmoji',
                          style: TextStyle(
                            decoration: item.isBought
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                          ),
                        ),
                        subtitle: Text(
                            '${item.quantity} ${_getUnitLabel(item.unit)}'),
                        trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              setState(() {
                                context
                                    .read<ListDetailsBloc>()
                                    .add(DeleteItemEvent(item));
                              });
                            }),
                      );
                    },
                  ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final result = await Navigator.of(context)
                .pushNamed(AddItemScreen.id) as Map<String, dynamic>?;
            if (result != null) {
              int id = 0;
              if (state.shoppingList!.items.isNotEmpty) {
                id = state.shoppingList!.items
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
              if (!context.mounted) return;
              context.read<ListDetailsBloc>().add(AddItemEvent(newItem));
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
