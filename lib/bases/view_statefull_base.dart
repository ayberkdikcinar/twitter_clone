import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class StatefullBase<T extends StatefulWidget> extends State<T> {
  ThemeData get theme => Theme.of(context);
  TextTheme get textTheme => Theme.of(context).textTheme;

  double dynamicHeight(double height) => MediaQuery.of(context).size.height * height;
  double dynamicWidth(double width) => MediaQuery.of(context).size.width * width;
}
