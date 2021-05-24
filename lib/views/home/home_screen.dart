import 'package:budge_up/views/park/park_screen.dart';
import 'package:budge_up/views/parking_auto/parking_auto.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _screens = [
    ParkingAuto(),
    ParkScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
