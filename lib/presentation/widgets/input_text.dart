import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  const TextInput({
    required this.controller,
    required this.labelText,
    required this.obscureText,
    super.key,
  });

  final TextEditingController controller;
  final String labelText;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: labelText,
        border: const OutlineInputBorder(),
      ),
    );
  }
}
