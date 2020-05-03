import 'dart:ui';

import 'package:flutter/material.dart';


final darkTheme = ThemeData(
  primarySwatch: Colors.red,
  primaryColor: Colors.white,
  brightness: Brightness.dark,
  backgroundColor: const Color(0xFF303030),
  accentColor: Color(0xFF303030),
  accentIconTheme: IconThemeData(color: Colors.black),
  dividerColor: Color(0xCCFFFFFF),
  iconTheme: IconThemeData(color: Colors.white),
  buttonColor: Colors.white,
  appBarTheme: AppBarTheme(color: Colors.white, iconTheme: IconThemeData(color: Colors.white), textTheme: TextTheme(display1: TextStyle(color: Colors.white))),
  bottomAppBarTheme: BottomAppBarTheme(color: Colors.white),
  textTheme: TextTheme(body1: TextStyle(color: Color(0xEFFFFFFF))),
  buttonTheme: ButtonThemeData(buttonColor: Color(0xEFFFFFFF), textTheme: ButtonTextTheme.accent),
);
  

final lightTheme = ThemeData(
  primarySwatch: Colors.grey,
  primaryColor: Color(0xFF303030),
  brightness: Brightness.light,
  backgroundColor: const Color(0xFFE5E5E5),
  accentColor: Colors.black,
  accentIconTheme: IconThemeData(color: Colors.white),
  dividerColor: Color(0xFF303030),
  textTheme: TextTheme(body1: TextStyle(color: Color(0xFF303030))),
  buttonTheme: ButtonThemeData(buttonColor: Color(0xFF303030), textTheme: ButtonTextTheme.primary),
  inputDecorationTheme: InputDecorationTheme(
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: Color(0xCC303030),
      )
    ),
  )
);

class ThemeChanger with ChangeNotifier {
  ThemeData _themeData;

  ThemeChanger(this._themeData);

  getTheme() => _themeData;
  setTheme(ThemeData theme) {
    _themeData = theme;

    notifyListeners();
  }
}