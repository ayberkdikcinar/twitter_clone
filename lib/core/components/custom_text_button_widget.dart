import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  final String text;
  final backgroundColor;
  @required
  final VoidCallback onPressed;

  const CustomTextButton({
    Key key,
    this.text,
    this.onPressed,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () => onPressed(),
        style: ButtonStyle(
            //shape: MaterialStateProperty.all(StadiumBorder(side: BorderSide.none)),
            backgroundColor: MaterialStateProperty.all(backgroundColor),
            shape: MaterialStateProperty.all(StadiumBorder())),
        child: Text(text));
  }
}
