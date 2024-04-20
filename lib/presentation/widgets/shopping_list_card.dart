import 'package:basket_buddy/constants/list_decorations.dart';
import 'package:basket_buddy/data/models/shopping_list.dart';
import 'package:basket_buddy/data/repositories/basket_buddy_database.dart';
import 'package:basket_buddy/presentation/screens/all_lists_screen/bloc/all_lists_bloc.dart';
import 'package:basket_buddy/presentation/screens/all_lists_screen/bloc/all_lists_event.dart';
import 'package:basket_buddy/presentation/screens/modify_list_screen/modify_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShoppingListCard extends StatelessWidget {
  const ShoppingListCard({
    required this.positionNumber,
    required this.presentedList,
    required this.touchFunction,
    required this.deleteFunction,
    required this.textEditingController,
    super.key,
  });

  final int positionNumber;
  final ShoppingList presentedList;
  final void Function() touchFunction;
  final void Function() deleteFunction;
  final TextEditingController textEditingController;

  @override
  Widget build(BuildContext context) {
    final basketBuddyDatabase =
        RepositoryProvider.of<BasketBuddyDataBase>(context);
    final bool canBeDeleted = presentedList.canBeDeleted();

    return GestureDetector(
      onTap: touchFunction,
      child: Container(
        height: 100.0,
        color: listColors[presentedList.color],
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              width: 30.0,
              child: Center(
                child: Text(
                  positionNumber.toString(),
                  style: const TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Text(
                "${listEmojis[presentedList.emoji]} ${presentedList.name}",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25.0,
                ),
                softWrap: true,
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
              ),
            ),
            Expanded(
              flex: 1,
              child: GestureDetector(
                onTap: () async {
                  final result = await Navigator.of(context).pushNamed(
                    ModifyListScreen.id,
                    arguments: {
                      'nameController': textEditingController,
                      'shoppingList': presentedList,
                    },
                  ) as Map<String, dynamic>?;
                  if (!context.mounted) return;
                  if (result == null) {
                    return;
                  }
                  ShoppingList newList = ShoppingList(
                    id: presentedList.id,
                    name: result["name"],
                    color: result["color"],
                    emoji: result["emoji"],
                    owner: basketBuddyDatabase.user.id,
                  );

                  context.read<AllListsBloc>().add(ModifyListEvent(newList));
                },
                child: const Icon(
                  Icons.edit,
                  color: Colors.black,
                  size: 40.0,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: GestureDetector(
                onTap: canBeDeleted ? deleteFunction : null,
                child: Icon(
                  Icons.delete_forever,
                  color: canBeDeleted ? Colors.red : Colors.grey,
                  size: 40.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
