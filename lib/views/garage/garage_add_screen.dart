import 'package:budge_up/models/auto_model.dart';
import 'package:budge_up/presentation/text_styles.dart';
import 'package:budge_up/presentation/widgets.dart';
import 'package:budge_up/views/garage/garage_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GarageAddScreen extends StatefulWidget {
  final AutoModel? auto;
  const GarageAddScreen({Key? key, this.auto}) : super(key: key);

  @override
  _GarageAddScreenState createState() => _GarageAddScreenState();
}

class _GarageAddScreenState extends State<GarageAddScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<GarageProvider>(context, listen: false).setUp();
    if (widget.auto != null) {
      Provider.of<GarageProvider>(context, listen: false).numberAuto =
          widget.auto!.number;
      Provider.of<GarageProvider>(context, listen: false).modelAuto =
          widget.auto!.model;
      Provider.of<GarageProvider>(context, listen: false).markAuto =
          widget.auto!.brand;
    }
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
                    initialValue:
                        widget.auto != null ? widget.auto!.brand : null,
                    onChanged: (value) {
                      provider.markAuto = value;
                    },
                    decoration: InputDecoration(
                      hintText: 'Марка авто *',
                    ),
                  ),
                  SizedBox(height: 24),
                  TextFormField(
                    initialValue:
                        widget.auto != null ? widget.auto!.model : null,
                    onChanged: (value) {
                      provider.modelAuto = value;
                    },
                    decoration: InputDecoration(
                      hintText: 'Модель авто *',
                    ),
                  ),
                  SizedBox(height: 24),
                  TextFormField(
                    initialValue:
                        widget.auto != null ? widget.auto!.number : null,
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
                        provider.create(
                            id: widget.auto != null ? widget.auto!.id : 0,
                            onSuccess: () {
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
