import 'package:budge_up/presentation/custom_icons.dart';
import 'package:budge_up/views/garage/garage_add_screen.dart';
import 'package:flutter/material.dart';

class GarageScreen extends StatefulWidget {
  const GarageScreen({Key? key}) : super(key: key);

  @override
  _GarageScreenState createState() => _GarageScreenState();
}

class _GarageScreenState extends State<GarageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Мой гараж'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GarageAddScreen()),
                );
              },
              icon: CustomIcon(
                customIcon: CustomIcons.addNew,
              ))
        ],
      ),
    );
  }
}
