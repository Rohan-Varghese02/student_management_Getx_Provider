import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomTextfield extends StatelessWidget {
  final TextEditingController text_controller;
  final String label;
  CustomTextfield({
    super.key,
    required this.text_controller,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: text_controller,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Provide $label';
        } else {
          return null;
        }
      },
      decoration: InputDecoration(
        label: Text(label),
        labelStyle: TextStyle(color: Colors.black),
        border: OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.green),
        ),
      ),
    );
  }
}
