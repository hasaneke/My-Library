import 'package:flutter/material.dart';
import 'package:my_library/res/font_styles.dart';

abstract class Themes {
  static final limetheme = ThemeData(
    unselectedWidgetColor: Colors.black45,
    selectedRowColor: Colors.black,
    scaffoldBackgroundColor: Colors.lime[50],
    fontFamily: FontStyles.selectedFont,
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
      elevation: MaterialStateProperty.all<double>(6),
      minimumSize: MaterialStateProperty.all<Size>(const Size(90, 40)),
      backgroundColor:
          MaterialStateProperty.all<Color>(Colors.lime[50] ?? Colors.red),
    )),
    textTheme: const TextTheme(
        bodyText1: TextStyle(color: Colors.purple, fontSize: 20)),
    primaryColor: Colors.black,
    iconTheme: const IconThemeData(
      color: Colors.black87,
    ),
  );
}
