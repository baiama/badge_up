import 'package:budge_up/components/alerts.dart';
import 'package:budge_up/presentation/text_styles.dart';
import 'package:budge_up/presentation/widgets.dart';
import 'package:budge_up/views/parking_auto/scanner_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ScannerScreen extends StatelessWidget {
  const ScannerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ScannerProvider(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Сканировать номер'),
        ),
        body: Consumer<ScannerProvider>(
          builder: (context, provider, Widget? child) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  GestureDetector(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return ImageAlert(
                              onImageSelected: (image) {
                                provider.check(image);
                              },
                            );
                          });
                    },
                    child: Text(
                      'Выбрать фото',
                      style: kInterReg16ColorBlack,
                    ),
                  ),
                  SizedBox(height: 40),
                  if (provider.plateNum != null)
                    Text(
                      'Номер вашей машины',
                      style: kInterReg16ColorBlack,
                      textAlign: TextAlign.center,
                    ),
                  SizedBox(height: 12),
                  if (provider.plateNum != null)
                    Text(
                      provider.plateNum!,
                      style: kInterBold18,
                      textAlign: TextAlign.center,
                    ),
                  if (provider.error != null)
                    Text(
                      provider.error!,
                      style: kInterReg16ColorBlack,
                    ),
                  Spacer(),
                  ElevatedButton(
                    onPressed: provider.plateNum != null ? () {} : null,
                    child: provider.isRequestSend
                        ? CircularLoader()
                        : Text('Потвердить'),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
