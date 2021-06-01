import 'package:flutter/material.dart';

class ParkScreen extends StatefulWidget {
  const ParkScreen({Key? key}) : super(key: key);

  @override
  _ParkScreenState createState() => _ParkScreenState();
}

class _ParkScreenState extends State<ParkScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Парковки'),
      ),
    );
  }
}
