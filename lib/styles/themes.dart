import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shopapp/styles/colors.dart';

ThemeData darkTheme = ThemeData(
  primarySwatch: defaultColor,
  scaffoldBackgroundColor: HexColor('333739'),
  appBarTheme: AppBarTheme(
    iconTheme: const IconThemeData(color: Colors.white),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: HexColor('333739'),
      statusBarBrightness: Brightness.light,
    ),
    titleTextStyle: const TextStyle(
      color: Colors.white,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
    backgroundColor: HexColor('333739'),
    elevation: 0.0,
  ),
  // floatingActionButtonTheme:
  //     const FloatingActionButtonThemeData(backgroundColor: defaultColor),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: defaultColor,
    unselectedItemColor: Colors.grey,
    elevation: 30.0,
    backgroundColor: HexColor('333739'),
  ),
  textTheme: const TextTheme(
    bodyMedium: TextStyle(
        fontSize: 18.0, fontWeight: FontWeight.w600, color: Colors.white),
  ),
);

ThemeData lightTheme = ThemeData(
  primarySwatch: defaultColor,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
    iconTheme: IconThemeData(color: Colors.black),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarBrightness: Brightness.dark,
    ),
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
    backgroundColor: Colors.white,
    elevation: 0.0,
  ),
  // floatingActionButtonTheme:
  //     const FloatingActionButtonThemeData(backgroundColor: defaultColor),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      unselectedItemColor: Colors.grey,
      selectedItemColor: defaultColor,
      backgroundColor: Colors.white,
      elevation: 30.0),
  textTheme: const TextTheme(
    bodyMedium: TextStyle(
        fontSize: 18.0, fontWeight: FontWeight.w600, color: Colors.black),
  ),
);
