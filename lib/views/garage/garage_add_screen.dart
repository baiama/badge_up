import 'package:budge_up/presentation/text_styles.dart';
import 'package:budge_up/presentation/widgets.dart';
import 'package:budge_up/views/garage/garage_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GarageAddScreen extends StatefulWidget {
  const GarageAddScreen({Key? key}) : super(key: key);

  @override
  _GarageAddScreenState createState() => _GarageAddScreenState();
}

class _GarageAddScreenState extends State<GarageAddScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<GarageProvider>(context, listen: false).setUp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Добавить авто'),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        onVerticalDragUpdate: (details) {
          if (details.primaryDelta != null) {
            if (details.primaryDelta! > 15 || details.primaryDelta! < 15) {
              FocusScope.of(context).unfocus();
            }
          }
        },
        child: Consumer<GarageProvider>(
          builder: (BuildContext context, provider, Widget? child) {
            return Container(
              color: Colors.white,
              padding: EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 25),
                  TextFormField(
                    onChanged: (value) {
                      provider.markAuto = value;
                    },
                    decoration: InputDecoration(
                      hintText: 'Марка авто *',
                    ),
                  ),
                  SizedBox(height: 24),
                  TextFormField(
                    onChanged: (value) {
                      provider.modelAuto = value;
                    },
                    decoration: InputDecoration(
                      hintText: 'Модель авто *',
                    ),
                  ),
                  SizedBox(height: 24),
                  TextFormField(
                    onChanged: (value) {
                      provider.numberAuto = value;
                    },
                    decoration: InputDecoration(
                      hintText: 'Номер авто *',
                    ),
                  ),
                  SizedBox(height: 24),
                  Text(
                    provider.error,
                    style: kInterReg16ColorCC6666,
                    textAlign: TextAlign.center,
                  ),
                  Expanded(child: Container()),
                  ElevatedButton(
                      onPressed: () {
                        provider.create(onSuccess: () {
                          Navigator.pop(context);
                        });
                      },
                      child: provider.isRequestSend
                          ? CircularLoader()
                          : Text('Добавить')),
                  SizedBox(height: 96),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
