import 'package:basket_buddy/constants/list_decorations.dart';
import 'package:basket_buddy/data/models/shopping_list.dart';
import 'package:basket_buddy/presentation/widgets/input_text.dart';
import 'package:flutter/material.dart';

class ModifyListScreen extends StatelessWidget {
  const ModifyListScreen(
      {required this.nameController, required this.shoppingList, super.key});

  static const id = 'modify_list_screen';

  final TextEditingController nameController;
  final ShoppingList shoppingList;

  @override
  Widget build(BuildContext context) {
    nameController.text = shoppingList.name;

    final colorsNames = listColors.keys.toList();
    final emojisNames = listEmojis.keys.toList();

    String selectedColor = "White";
    String selectedEmoji = "s";

    return Scaffold(
      appBar: AppBar(
        title: const Text('Modify List'),
        backgroundColor: listColors[shoppingList.color] != Colors.white
            ? listColors[shoppingList.color]
            : Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('Change List Name:'),
            const SizedBox(height: 20.0),
            TextInput(
              controller: nameController,
              labelText: 'List Name',
              obscureText: false,
            ),
            const SizedBox(height: 20.0),
            const Text('Change List Color:'),
            Wrap(
              spacing: 8.0,
              children: List.generate(
                5,
                (index) => GestureDetector(
                  onTap: () {
                    selectedColor = colorsNames[index];
                  },
                  child: Container(
                    width: 40.0,
                    height: 40.0,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                        width: 2,
                      ),
                      color: listColors[colorsNames[index]],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            const Text('Change List Emoji:'),
            Wrap(
              spacing: 8.0,
              children: List.generate(
                5,
                (index) => GestureDetector(
                  onTap: () {
                    selectedEmoji = emojisNames[index];
                  },
                  child: Text(
                    listEmojis[emojisNames[index]].toString(),
                    style: const TextStyle(fontSize: 24.0),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                String name = nameController.text;
                var listObject = {
                  "name": name,
                  "color": selectedColor,
                  "emoji": selectedEmoji
                };
                nameController.clear();
                Navigator.of(context).pop(listObject);
              },
              child: const Text('Modify List'),
            ),
          ],
        ),
      ),
    );
  }
}
