import 'package:budge_up/models/auto_model.dart';
import 'package:budge_up/models/month_model.dart';
import 'package:budge_up/presentation/color_scheme.dart';
import 'package:budge_up/presentation/text_styles.dart';
import 'package:budge_up/utils/strings.dart';
import 'package:budge_up/views/components/auto_item.dart';
import 'package:budge_up/views/garage/garage_add_screen.dart';
import 'package:budge_up/views/parking_auto/parking_auto_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

class PhoneView extends StatelessWidget {
  final Function onTap;
  final String phone;
  const PhoneView({Key? key, required this.onTap, required this.phone})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(
            phone,
            style: kInterReg16ColorBlack,
          ),
          GestureDetector(
            onTap: () {
              onTap();
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 22, vertical: 6),
              child: Text(
                'Изменить номер',
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
              SizedBox(height: 25),
              ListView.builder(
                  itemCount: widget.items.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          autoModel = widget.items[index];
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.only(bottom: 21),
                        decoration: BoxDecoration(
                            color: widget.items[index].id == autoModel.id
                                ? kColorF8F8F8
                                : Colors.white),
                        child: AutoItem(
                          onDelete: null,
                          auto: widget.items[index],
                          isLoading: false,
                        ),
                      ),
                    );
                  }),
              SizedBox(height: 10),
              ElevatedButton(
                  onPressed: () {
                    widget.onTap(autoModel);
                    Navigator.pop(context);
                  },
                  child: Text('Готово')),
              if (widget.items.length < 5)
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => GarageAddScreen(
                                auto: null,
                              )),
                    ).then((value) {
                      Provider.of<ParkingAutoProvider>(context, listen: false)
                          .getItems();
                      Navigator.pop(context);
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.only(left: 22, right: 22, top: 26),
                    child: Text(
                      'Добавить новый авто',
                      style: kInterReg16ColorCC6666.copyWith(
                        color: kColor2980B9,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 22, vertical: 26),
                  child: Text(
                    'Отменить',
                    style: kInterReg16ColorCC6666.copyWith(
                      color: kColor2980B9,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MonthListView extends StatelessWidget {
  final Function(int) onSelected;
  const MonthListView({Key? key, required this.onSelected}) : super(key: key);

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
                'Выберите месяц',
                style: kInterSemiBold18,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 25),
              ListView.builder(
                  itemCount: MonthModel.month.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        onSelected(index);
                      },
                      child: Container(
                        padding: EdgeInsets.only(bottom: 21),
                        decoration: BoxDecoration(color: Colors.white),
                        child: Text(
                          MonthModel.month[index],
                          style: kInterReg16ColorBlack,
                        ),
                      ),
                    );
                  }),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 22, vertical: 20),
                  child: Text(
                    'Отменить',
                    style: kInterReg16ColorCC6666.copyWith(
                      color: kColor2980B9,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PhoneEditView extends StatefulWidget {
  final Function(String) onTap;
  final String? phone;
  const PhoneEditView({Key? key, required this.onTap, this.phone}) : super(key: key);

  @override
  _PhoneEditViewState createState() => _PhoneEditViewState();
}

class _PhoneEditViewState extends State<PhoneEditView> {
  String phone = '';
  String error = '';
  @override
  void initState() {
    super.initState();
    phone = '';
    error = '';
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SizedBox(
        width: MediaQuery.of(context).size.width - 24,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Изменить номер телефона',
              style: kInterSemiBold18,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 26),
            TextFormField(
              initialValue: widget.phone,
              onChanged: (value) {
                phone = value;
                setState(() {
                  error = '';
                });
              },
              decoration: InputDecoration(
                hintText: '+79268105001',
              ),
            ),
            if (error.length > 0) SizedBox(height: 24),
            if (error.length > 0)
              Text(
                error,
                style: kInterReg16ColorCC6666,
                textAlign: TextAlign.center,
              ),
            SizedBox(height: 26),
            ElevatedButton(
                onPressed: () {
                  if (phone.length == 0) {
                    setState(() {
                      error = Strings.errorEmpty + 'Телефон';
                    });
                    return;
                  }

                  if (!phone.startsWith('+')) {
                    phone = '+' + phone;
                  }

                  if (phone.length != 12) {
                    setState(() {
                      error = Strings.errorEmpty2 + 'Телефон';
                    });
                    return;
                  }
                  widget.onTap(phone);
                  Navigator.pop(context);
                },
                child: Text('Готово')),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 22, vertical: 26),
                child: Text(
                  'Отменить',
                  style: kInterReg16ColorCC6666.copyWith(
                    color: kColor2980B9,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
