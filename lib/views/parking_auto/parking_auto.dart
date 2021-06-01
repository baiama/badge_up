import 'package:budge_up/views/park/park_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ParkingAuto extends StatefulWidget {
  const ParkingAuto({Key? key}) : super(key: key);

  @override
  _ParkingAutoState createState() => _ParkingAutoState();
}

class _ParkingAutoState extends State<ParkingAuto> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      Provider.of<ParkProvider>(context, listen: false).getItems();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Парковать авто'),
      ),
      body: Container(
        child: Consumer<ParkProvider>(
          builder: (context, provider, Widget? child) {
            return SingleChildScrollView(
              child: Column(
                children: [],
              ),
            );
          },
        ),
      ),
    );
  }
}
