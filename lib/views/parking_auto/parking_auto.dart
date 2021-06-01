import 'package:budge_up/presentation/color_scheme.dart';
import 'package:budge_up/presentation/text_styles.dart';
import 'package:budge_up/views/components/auto_item.dart';
import 'package:budge_up/views/garage/garage_add_screen.dart';
import 'package:budge_up/views/parking_auto/parking_auto_provider.dart';
import 'package:budge_up/views/settings/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'components.dart';

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
      Provider.of<ParkingAutoProvider>(context, listen: false).setPhone =
          Provider.of<SettingsProvider>(context, listen: false).user.phone;
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
                        auto: provider.selectedAuto,
                        onDelete: null,
                        isLoading: false),
                  if (provider.items.length > 0)
                    GestureDetector(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AutoListView(
                                onTap: (value) {
                                  provider.setSelectedAuto = value;
                                },
                                selectedAuto: provider.selectedAuto,
                                items: provider.items,
                              );
                            });
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 22, vertical: 8),
                        child: Text(
                          'Выбрать другой авто',
                          style: kInterReg16ColorCC6666.copyWith(
                            color: kColor2980B9,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
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
                  SizedBox(height: 25),
                  PhoneView(
                    phone: provider.phone,
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return PhoneEditView(
                              onTap: (value) {
                                provider.setPhone = value;
                              },
                            );
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
