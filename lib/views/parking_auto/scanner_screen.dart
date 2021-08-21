import 'package:budge_up/components/alerts.dart';
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
                    child: Text('Выбрать фото'),
                  ),
                  Spacer(),
                  ElevatedButton(onPressed: () {}, child: Text('Потвердить'))
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
