import 'package:budge_up/presentation/custom_themes.dart';
import 'package:budge_up/views/garage/garage_provider.dart';
import 'package:budge_up/views/initial/initial_screen.dart';
import 'package:budge_up/views/parking_auto/parking_auto_provider.dart';
import 'package:budge_up/views/settings/settings_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:in_app_notification/in_app_notification.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InAppNotification(
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => SettingsProvider()),
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
      ),
    );
  }
}
