import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final int maxLines;
  final String labelText;
  final TextEditingController controller;
  final double borderRadious;
  final Function(String value) onChanged;
  final String initialVal;
  const CustomTextFormField({
    Key key,
    this.maxLines = 1,
    this.labelText = '',
    this.controller,
    this.borderRadious = 15,
    this.onChanged,
    this.initialVal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(borderRadious)),
        labelText: labelText,
      ),
      controller: controller,
      onChanged: (value) => onChanged(value),
      initialValue: initialVal,
    );
  }
}
