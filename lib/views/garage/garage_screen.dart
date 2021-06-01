import 'package:budge_up/presentation/custom_icons.dart';
import 'package:budge_up/views/garage/garage_add_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'garage_provider.dart';

class GarageScreen extends StatefulWidget {
  const GarageScreen({Key? key}) : super(key: key);

  @override
  _GarageScreenState createState() => _GarageScreenState();
}

class _GarageScreenState extends State<GarageScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      Provider.of<GarageProvider>(context, listen: false).getItems();
    });
  }

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
        body: Consumer<GarageProvider>(
          builder: (context, provider, Widget? child) {
            if (provider.isRequestSend) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return Container(
              child: ListView.builder(
                  itemCount: provider.items.length,
                  itemBuilder: (context, index) {
                    return Container();
                  }),
            );
          },
        ));
  }
}
