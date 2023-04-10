import 'package:air_pollution/screen/home_screen.dart';
import 'package:air_pollution/screen/test_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';


const testBox = 'test';

void main() async {
  await Hive.initFlutter();

  await Hive.openBox(testBox);

  runApp(
    MaterialApp(
      theme: ThemeData(
        fontFamily: 'sunflower',
      ),
      home: TestScreen(),
      // HomeScreen(),
    )
  );
}