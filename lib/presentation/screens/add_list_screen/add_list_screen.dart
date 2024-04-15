import 'package:basket_buddy/presentation/widgets/input_text.dart';
import 'package:flutter/material.dart';

class AddListScreen extends StatelessWidget {
  const AddListScreen({required this.nameController});

  static const id = 'add_list_screen';

  final TextEditingController nameController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New List'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('Select List Name:'),
            const SizedBox(height: 20.0),
            TextInput(
              controller: nameController,
              labelText: 'List Name',
              obscureText: false,
            ),
            const SizedBox(height: 20.0),
            Wrap(
              spacing: 8.0,
              children: List.generate(
                5,
                (index) => GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: 40.0,
                    height: 40.0,
                    color: Colors.primaries[index],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            const Text('Select List Emoji:'),
            Wrap(
              spacing: 8.0,
              children: List.generate(
                5,
                (index) => GestureDetector(
                  onTap: () {},
                  child: const Text(
                    '😀',
                    style: TextStyle(fontSize: 24.0),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                String name = nameController.text;
                var listObject = {"name": name, "color": "White", "emoji": "s"};
                nameController.clear();
                Navigator.of(context).pop(listObject);
              },
              child: const Text('Add List'),
            ),
          ],
        ),
      ),
    );
  }
}
