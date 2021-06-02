import 'package:budge_up/models/month_model.dart';
import 'package:budge_up/presentation/color_scheme.dart';
import 'package:budge_up/presentation/custom_icons.dart';
import 'package:budge_up/presentation/custom_themes.dart';
import 'package:budge_up/presentation/text_styles.dart';
import 'package:budge_up/presentation/widgets.dart';
import 'package:budge_up/utils/strings.dart';
import 'package:budge_up/views/components/auto_item.dart';
import 'package:budge_up/views/garage/garage_add_screen.dart';
import 'package:budge_up/views/parking_auto/parking_auto_provider.dart';
import 'package:budge_up/views/parking_auto/scanner_screen.dart';
import 'package:budge_up/views/parking_auto/search_result.dart';
import 'package:budge_up/views/settings/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
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

  final datePadding = EdgeInsets.symmetric(horizontal: 12);
  var dayMaskFormatter =
      new MaskTextInputFormatter(mask: '##', filter: {"#": RegExp(r'[0-9]')});
  var yearMaskFormatter =
      new MaskTextInputFormatter(mask: '####', filter: {"#": RegExp(r'[0-9]')});
  var timeMaskFormatter = new MaskTextInputFormatter(
      mask: '##:##', filter: {"#": RegExp(r'[0-9]')});

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
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 24),
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
                    SizedBox(height: 38),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(40),
                                ),
                                border: Border.all(
                                  color: kColorE8E8E8,
                                  width: 2,
                                )),
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    onChanged: (value) {
                                      provider.number = value;
                                      provider.updateView();
                                    },
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white,
                                      border: kInputDecorationBorder2,
                                      errorBorder: kInputDecorationBorder2,
                                      focusedBorder: kInputDecorationBorder2,
                                      focusedErrorBorder:
                                          kInputDecorationBorder2,
                                      disabledBorder: kInputDecorationBorder2,
                                      enabledBorder: kInputDecorationBorder2,
                                      hintText: 'Номер закрываемого авто',
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ScannerScreen()));
                                    },
                                    child: Container(
                                        padding:
                                            EdgeInsets.only(right: 12, left: 8),
                                        child: CustomIcon(
                                            customIcon: CustomIcons.scanner))),
                              ],
                            ),
                          ),
                        ),
                        if (provider.number.length > 3) SizedBox(width: 18),
                        if (provider.number.length > 3)
                          ElevatedButton(
                              style: ButtonStyle(
                                  padding: MaterialStateProperty.all(
                                      EdgeInsets.zero)),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        SearchResult(query: provider.number),
                                  ),
                                );
                              },
                              child: Text('Найти')),
                      ],
                    ),
                    SizedBox(height: 50),
                    Text(
                      'Когда вы планируете уехать?',
                      style: kInterBold16,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 27),
                    Row(
                      children: [
                        Expanded(
                          flex: 4,
                          child: TextField(
                            onChanged: (value) {
                              provider.day = value;
                            },
                            inputFormatters: [dayMaskFormatter],
                            decoration: InputDecoration(
                              hintText: '24',
                              contentPadding: datePadding,
                            ),
                          ),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          flex: 4,
                          child: GestureDetector(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return MonthListView(
                                      onSelected: (value) {
                                        provider.month = value;
                                        provider.updateView();
                                      },
                                    );
                                  });
                            },
                            child: Container(
                              padding: EdgeInsets.only(top: 14, bottom: 14),
                              decoration: BoxDecoration(
                                color: kColorF6F6F6,
                                borderRadius: BorderRadius.circular(51),
                                border: Border.all(
                                  color: kColorE8E8E8,
                                ),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                MonthModel.monthShort[provider.month],
                                style: kInterReg16ColorBDBDBD,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          flex: 5,
                          child: TextField(
                            onChanged: (value) {
                              provider.year = value;
                            },
                            inputFormatters: [yearMaskFormatter],
                            decoration: InputDecoration(
                              hintText: '2021',
                              contentPadding: datePadding,
                            ),
                          ),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                            flex: 5,
                            child: TextField(
                              onChanged: (value) {
                                provider.time = value;
                              },
                              inputFormatters: [timeMaskFormatter],
                              decoration: InputDecoration(
                                hintText: '18:00',
                                contentPadding: datePadding,
                              ),
                            )),
                      ],
                    ),
                    SizedBox(height: 27),
                    Text(
                      'Местное время',
                      style:
                          kInterReg16ColorBDBDBD.copyWith(color: kColor999999),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 50),
                    ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.resolveWith<Color>(
                                    (Set<MaterialState> states) {
                              if (states.contains(MaterialState.disabled)) {
                                return kColorCCCCCC;
                              }
                              return kColor2980B9;
                            }),
                            padding:
                                MaterialStateProperty.all(EdgeInsets.zero)),
                        onPressed: () {
                          provider.create(onSuccess: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: Colors.white,
                                content: Text(
                                  Strings.successCreatePark,
                                  style: kInterReg16ColorBlack,
                                ),
                              ),
                            );
                          }, onFailure: (value) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: Colors.white,
                                content: Text(
                                  value,
                                  style: kInterReg16ColorBlack,
                                ),
                              ),
                            );
                          });
                        },
                        child: provider.isCreating
                            ? CircularLoader()
                            : Text('Парковаться')),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
