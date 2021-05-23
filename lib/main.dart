import 'package:budge_up/presentation/custom_themes.dart';
import 'package:budge_up/views/initial/initial_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: kAppBarTheme,
        inputDecorationTheme: kInputDecorationTheme,
        elevatedButtonTheme: kElevationButtonTheme,
      ),
      home: InitialScreen(),
    );
  }
}
