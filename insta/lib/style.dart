import 'package:flutter/material.dart';

// _ = 다른 파일에서 import 제외
// var _var1;

var theme = ThemeData(
  appBarTheme: AppBarTheme(
    color: Colors.white,
    iconTheme: IconThemeData(color: Colors.black, size: 30),
    titleTextStyle: TextStyle(color: Colors.black, fontSize: 25),
    elevation: 1,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    selectedItemColor: Colors.black,
  ),
);