import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final Function(String value) onChanged;
  final hintText;
  final Icon prefixIcon;
  final Function onTap;
  const CustomTextField({
    Key key,
    this.onChanged,
    this.hintText,
    this.prefixIcon,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        hintText: hintText,
        prefixIcon: prefixIcon,
        alignLabelWithHint: true,
      ),
      onChanged: (value) => onChanged(value),
      onTap: onTap,
    );
  }
}
