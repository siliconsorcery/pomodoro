import 'package:flutter/material.dart';

final theme = ThemeData(
  appBarTheme: AppBarTheme(color: Color(0xFF33691e)),
  scaffoldBackgroundColor: Color(0xFFf44336),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      primary: Color(0xFFef5350),
      textStyle: TextStyle(
          fontFamily: 'Segoe UI',
          inherit: true,
          color: Colors.black,
          decoration: TextDecoration.none,
          fontSize: 56),
      padding: const EdgeInsets.all(32),
    ),
  ),
  fontFamily: "Roboto",
  primaryTextTheme: TextTheme(
    headline1: TextStyle(
      fontFamily: 'Segoe UI',
      inherit: true,
      color: Colors.black,
      decoration: TextDecoration.none,
    ),
    headline2: TextStyle(
        fontFamily: 'Segoe UI',
        inherit: true,
        color: Colors.black,
        decoration: TextDecoration.none),
    headline3: TextStyle(
        fontFamily: 'Segoe UI',
        inherit: true,
        color: Colors.black,
        decoration: TextDecoration.none),
    headline4: TextStyle(
        fontFamily: 'Segoe UI',
        inherit: true,
        color: Colors.black,
        decoration: TextDecoration.none),
    headline5: TextStyle(
        fontFamily: 'Segoe UI',
        inherit: true,
        color: Colors.black,
        decoration: TextDecoration.none),
    headline6: TextStyle(
        fontFamily: 'Segoe UI',
        inherit: true,
        color: Colors.black,
        decoration: TextDecoration.none),
    bodyText1: TextStyle(
        fontFamily: 'Segoe UI',
        inherit: true,
        color: Colors.black,
        decoration: TextDecoration.none),
    bodyText2: TextStyle(
        fontFamily: 'Segoe UI',
        inherit: true,
        color: Colors.black,
        decoration: TextDecoration.none),
    subtitle1: TextStyle(
        fontFamily: 'Segoe UI',
        inherit: true,
        color: Colors.black,
        decoration: TextDecoration.none),
    subtitle2: TextStyle(
        fontFamily: 'Segoe UI',
        inherit: true,
        color: Colors.black,
        decoration: TextDecoration.none),
    caption: TextStyle(
        fontFamily: 'Segoe UI',
        inherit: true,
        color: Colors.black,
        decoration: TextDecoration.none),
    button: TextStyle(
        fontFamily: 'Segoe UI',
        inherit: true,
        color: Colors.black,
        decoration: TextDecoration.none),
    overline: TextStyle(
        fontFamily: 'Segoe UI',
        inherit: true,
        color: Colors.black,
        decoration: TextDecoration.none),
  ),
  textTheme: Typography.material2018().englishLike,
);
