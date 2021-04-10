import 'package:flutter/material.dart';

import 'ITheme.dart';

class DarkTheme extends ITheme {
  static DarkTheme _instance;
  static DarkTheme get instance {
    if (_instance != null) {
      return _instance;
    }
    _instance = DarkTheme._init();
    return _instance;
  }

  DarkTheme._init();

  final ThemeData _darkTheme = ThemeData.dark();

  @override
  ThemeData get data => ThemeData(
        appBarTheme: _darkTheme.appBarTheme.copyWith(backgroundColor: Colors.black87),
        colorScheme: _darkTheme.colorScheme.copyWith(primary: Colors.white),
        backgroundColor: Colors.black,
        accentColor: Colors.blueAccent,
        buttonColor: Colors.black38,
        canvasColor: Color.fromARGB(255, 208, 208, 208),
        cardColor: Colors.amber.shade800,
        scaffoldBackgroundColor: Colors.black38,
      );
}
