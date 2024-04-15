import 'package:basket_buddy/data/models/shopping_list.dart';
import 'package:flutter/material.dart';

class ShoppingListCard extends StatelessWidget {
  ShoppingListCard({
    required this.positionNumber,
    required this.presentedList,
    required this.touchFunction,
    required this.deleteFunction,
    required this.editListName,
    required this.textEditingController,
  });

  final int positionNumber;
  final ShoppingList presentedList;
  final void Function() touchFunction;
  final void Function() deleteFunction;
  final void Function(bool) editListName;
  final TextEditingController textEditingController;
  bool isEditable = false;

  @override
  Widget build(BuildContext context) {
    final bool canBeDeleted = presentedList.canBeDeleted();

    return GestureDetector(
      onTap: touchFunction,
      child: Container(
        height: 100.0,
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  isEditable
                      ? TextField(
                          controller: textEditingController,
                        )
                      : Text(
                          presentedList.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25.0,
                          ),
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                        ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: GestureDetector(
                onTap: () {
                  editListName(isEditable);
                },
                child: Icon(
                  Icons.edit,
                  color: isEditable ? Colors.blue : Colors.grey,
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
