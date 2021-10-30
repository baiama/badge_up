import 'package:budge_up/api/scanner_api.dart';
import 'package:budge_up/presentation/text_styles.dart';
import 'package:budge_up/presentation/widgets.dart';
import 'package:budge_up/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ScannerScreen extends StatefulWidget {
  const ScannerScreen({Key? key}) : super(key: key);

  @override
  _ScannerScreenState createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  bool _isLoading = false;
  String? _error;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _startImage();
    });
  }

  void _startImage() async {
    var image = await Utils.getImage(ImageSource.camera);
    if (image == null) {
      Navigator.pop(context);
    }
    setState(() {
      _isLoading = true;
    });
    if (image != null) {
      ScannerApi().scanLight(
        image: image,
        onSuccess: _onSuccess,
        onFailure: (error) {
          ScannerApi().scan(
            image: image,
            onSuccess: _onSuccess,
            onFailure: _onFailure,
          );
        },
      );
    }
  }

  void _onSuccess(String value) {
    if (value.toLowerCase() == 'NULL'.toLowerCase()) {
      setState(() {
        _isLoading = false;
        _error = "Номер не определен";
      });
    } else {
      setState(() {
        _isLoading = false;
      });

      if (value.length > 0) {
        String letter = '';
        for (int i = 0; i < value.length; i++) {
          String char = value[i];
          switch (char.toUpperCase()) {
            case 'A':
              letter = letter + 'А';
              break;
            case 'B':
              letter = letter + 'В';
              break;
            case 'E':
              letter = letter + 'Е';
              break;
            case 'K':
              letter = letter + 'К';
              break;
            case 'M':
              letter = letter + 'М';
              break;
            case 'H':
              letter = letter + 'Н';
              break;
            case 'H':
              letter = letter + 'Н';
              break;
            case 'O':
              letter = letter + 'О';
              break;
            case 'P':
              letter = letter + 'Р';
              break;
            case 'C':
              letter = letter + 'С';
              break;
            case 'T':
              letter = letter + 'Т';
              break;
            case 'Y':
              letter = letter + 'У';
              break;
            case 'X':
              letter = letter + 'Х';
              break;
            default:
              break;
          }
        }
        Navigator.pop(context, letter);
      } else {
        Navigator.pop(context, value);
      }
    }
  }

  void _onFailure(String error) {
    setState(() {
      _isLoading = false;
      _error = error;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Сканировать номер'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 100),
            if (_isLoading)
              Container(
                alignment: Alignment.topCenter,
                child: CircularLoader(),
              ),
            SizedBox(height: 20),
            if (_error != null)
              Text(
                _error!,
                style: kInterReg16ColorBlack,
                textAlign: TextAlign.center,
              ),
            Spacer(),
            if (_error != null)
              ElevatedButton(
                onPressed: () {
                  _startImage();
                },
                child: Text('Попробовать снова'),
              )
          ],
        ),
      ),
    );
  }
}

// class ff extends StatelessWidget {
//   const ff({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (context) => ScannerProvider(),
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text('Сканировать номер'),
//         ),
//         body: Consumer<ScannerProvider>(
//           builder: (context, provider, Widget? child) {
//             return Container(
//               padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   GestureDetector(
//                     onTap: () {
//                       showDialog(
//                           context: context,
//                           builder: (context) {
//                             return ImageAlert(
//                               onImageSelected: (image) {
//                                 provider.check(image);
//                               },
//                             );
//                           });
//                     },
//                     child: Text(
//                       'Выбрать фото',
//                       style: kInterReg16ColorBlack,
//                     ),
//                   ),
//                   SizedBox(height: 40),
//                   if (provider.plateNum != null)
//                     Text(
//                       'Номер вашей машины',
//                       style: kInterReg16ColorBlack,
//                       textAlign: TextAlign.center,
//                     ),
//                   SizedBox(height: 12),
//                   if (provider.plateNum != null)
//                     Text(
//                       provider.plateNum!,
//                       style: kInterBold18,
//                       textAlign: TextAlign.center,
//                     ),
//                   if (provider.error != null)
//                     Text(
//                       provider.error!,
//                       style: kInterReg16ColorBlack,
//                     ),
//                   Spacer(),
//                   ElevatedButton(
//                     onPressed: provider.plateNum != null
//                         ? () {
//                       Navigator.pop(context, provider.plateNum);
//                     }
//                         : null,
//                     child: provider.isRequestSend
//                         ? CircularLoader()
//                         : Text('Потвердить'),
//                   )
//                 ],
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
