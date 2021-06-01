import 'package:budge_up/presentation/custom_icons.dart';
import 'package:budge_up/presentation/widgets.dart';
import 'package:budge_up/views/components/auto_item.dart';
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
                  ).then((value) {
                    Provider.of<GarageProvider>(context, listen: false)
                        .getItems();
                  });
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

            if (!provider.isViewSetup) {
              return Container();
            }

            if (provider.items.length == 0) {
              return Container(
                padding: EdgeInsets.only(top: 50),
                alignment: Alignment.center,
                child: EmptyData(
                    title: 'В вашем гараже нет\nни одного автомобиля'),
              );
            }

            return Container(
              child: ListView.builder(
                  itemCount: provider.items.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => GarageAddScreen(
                                      auto: provider.items[index],
                                    )),
                          ).then((value) {
                            Provider.of<GarageProvider>(context, listen: false)
                                .getItems();
                          });
                        },
                        child: AutoItem(
                            auto: provider.items[index],
                            onDelete: (value) {
                              provider.delete(value);
                            },
                            isLoading: provider.isLoading &&
                                provider.items[index].id == provider.id),
                      ),
                    );
                  }),
            );
          },
        ));
  }
}
