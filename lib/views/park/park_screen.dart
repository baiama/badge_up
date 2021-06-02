import 'package:budge_up/views/park/park_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ParkScreen extends StatefulWidget {
  const ParkScreen({Key? key}) : super(key: key);

  @override
  _ParkScreenState createState() => _ParkScreenState();
}

class _ParkScreenState extends State<ParkScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => ParkProvider(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Парковки'),
        ),
        body: ParkBody(),
      ),
    );
  }
}

class ParkBody extends StatefulWidget {
  const ParkBody({Key? key}) : super(key: key);

  @override
  _ParkBodyState createState() => _ParkBodyState();
}

class _ParkBodyState extends State<ParkBody> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      Provider.of<ParkProvider>(context, listen: false).getItems();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
