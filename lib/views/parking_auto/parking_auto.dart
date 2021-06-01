import 'package:budge_up/models/auto_model.dart';
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
                                onTap: (value) {},
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

class AutoListView extends StatefulWidget {
  final Function(AutoModel) onTap;
  final AutoModel selectedAuto;
  final List<AutoModel> items;
  AutoListView({
    required this.onTap,
    required this.selectedAuto,
    required this.items,
  });

  @override
  _AutoListViewState createState() => _AutoListViewState();
}

class _AutoListViewState extends State<AutoListView> {
  AutoModel autoModel = AutoModel();

  @override
  void initState() {
    super.initState();
    autoModel = widget.selectedAuto;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SizedBox(
        height: 500,
        width: MediaQuery.of(context).size.width - 48,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Выбрать другой авто',
                style: kInterSemiBold18,
                textAlign: TextAlign.center,
              ),
              ListView.builder(
                  itemCount: widget.items.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.only(bottom: 21),
                      decoration: BoxDecoration(
                          color: widget.items[index].id == autoModel.id
                              ? kColorF8F8F8
                              : Colors.transparent),
                      child: AutoItem(
                        onDelete: null,
                        auto: widget.items[index],
                        isLoading: false,
                      ),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
