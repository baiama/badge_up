import 'package:budge_up/presentation/custom_themes.dart';
import 'package:budge_up/views/auth/login/login_provider.dart';
import 'package:budge_up/views/auth/register/register_provider.dart';
import 'package:budge_up/views/auth/reset_password/reset_password_provider.dart';
import 'package:budge_up/views/garage/garage_provider.dart';
import 'package:budge_up/views/initial/initial_screen.dart';
import 'package:budge_up/views/park/park_provider.dart';
import 'package:budge_up/views/parking_auto/parking_auto_provider.dart';
import 'package:budge_up/views/settings/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => RegisterProvider()),
        ChangeNotifierProvider(create: (_) => LoginProvider()),
        ChangeNotifierProvider(create: (_) => SettingsProvider()),
        ChangeNotifierProvider(create: (_) => ResetPasswordProvider()),
        ChangeNotifierProvider(create: (_) => ParkProvider()),
        ChangeNotifierProvider(create: (_) => ParkingAutoProvider()),
        ChangeNotifierProvider(create: (_) => GarageProvider()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: kAppBarTheme,
          inputDecorationTheme: kInputDecorationTheme,
          elevatedButtonTheme: kElevationButtonTheme,
        ),
        home: InitialScreen(),
      ),
    );
  }
}
