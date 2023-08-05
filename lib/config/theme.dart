// ignore_for_file: avoid_print, deprecated_member_use

import 'package:flutter/material.dart';

ThemeData theme() {
  print("Theme is running");
  return ThemeData(
      primarySwatch: buildMaterialColor(const Color(0xFFEED70B)),
      primaryColor: const Color(0xFFEED70B),
      primaryColorDark: const Color(0xFFBBA802),
      primaryColorLight: const Color(0xFFFFF068),
      scaffoldBackgroundColor: Colors.white,
      backgroundColor: const Color(0xFFF5F5F5),
      cardColor: const Color(0xFFFC9C3C),
      fontFamily: 'Futura',
      textTheme: const TextTheme(
          headline1: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 36,
              fontFamily: 'Futura'),
          headline2: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 24,
              fontFamily: 'Futura'),
          headline3: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
          headline4: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
          headline5: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 14),
          headline6: TextStyle(
              color: Colors.black, fontWeight: FontWeight.normal, fontSize: 14),
          bodyText1: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.normal,
              fontSize: 14,
              fontFamily: 'Futura'),
          bodyText2: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.normal,
              fontSize: 12)));
}

buildMaterialColor(Color color) {
  List strengths = <double>[.05];
  Map<int, Color> swatch = {};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  for (var strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }
  return MaterialColor(color.value, swatch);
}
