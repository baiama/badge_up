import 'package:budge_up/presentation/color_scheme.dart';
import 'package:budge_up/presentation/text_styles.dart';
import 'package:budge_up/views/components/auto_item.dart';
import 'package:budge_up/views/garage/garage_add_screen.dart';
import 'package:budge_up/views/parking_auto/parking_auto_provider.dart';
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
      Provider.of<ParkingAutoProvider>(context, listen: false).getItems();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Парковать авто'),
      ),
      body: Container(
        child: Consumer<ParkingAutoProvider>(
          builder: (context, provider, Widget? child) {
            if (provider.isRequestSend) {
              return Container(
                padding: EdgeInsets.only(top: 100),
                alignment: Alignment.center,
                child: CircularProgressIndicator(),
              );
            }
            if (!provider.isViewSetup) {
              return Container();
            }

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 30),
                  if (provider.items.length > 0)
                    AutoItem(
                        auto: provider.items[0],
                        onDelete: null,
                        isLoading: false),
                  if (provider.items.length == 0)
                    EmptyCar(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => GarageAddScreen()),
                        ).then((value) {
                          Provider.of<ParkingAutoProvider>(context,
                                  listen: false)
                              .getItems();
                        });
                      },
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class EmptyCar extends StatelessWidget {
  final Function onTap;
  const EmptyCar({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(
            'Нет авто в гараже',
            style: kInterBold18,
          ),
          GestureDetector(
            onTap: () {
              onTap();
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 22, vertical: 6),
              child: Text(
                'Добавить авто в гараж',
                style: kInterReg16ColorCC6666.copyWith(
                  color: kColor2980B9,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
