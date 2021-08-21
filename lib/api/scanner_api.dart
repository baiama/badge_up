import 'dart:io';
import 'package:budge_up/utils/strings.dart';
import 'package:http_parser/http_parser.dart';
import 'package:dio/dio.dart';

final _scannerToken = 'c5753ae21010ffa5384132a7289f29cf40b22d6d';
final _scannerUrl = 'https://api.platerecognizer.com/v1/plate-reader/';

class ScannerApi {
  Future<void> scan({
    required File image,
    required Function(String) onSuccess,
    required Function(String) onFailure,
  }) async {
    BaseOptions options = new BaseOptions(
      connectTimeout: 5000,
      receiveTimeout: 3000,
      baseUrl: 'https://budgeup.ru/api/v1/',
      headers: {
        "accept": 'application/json',
      },
    );
    options.headers['Authorization'] = 'Token $_scannerToken';
    Dio dio = Dio(options);
    MultipartFile multipartFile = MultipartFile.fromFileSync(image.path,
        filename: image.path, contentType: MediaType("image", "png"));

    FormData formData = FormData.fromMap({
      "mmc": "true",
      "upload": multipartFile,
    });

    print(formData.fields);
    try {
      Response response = await dio.post(_scannerUrl, data: formData);
      print(response.data);
      if (response.statusCode == 201 || response.statusCode == 200) {
        Iterable? itemsJson = response.data['results'];
        if (itemsJson != null && itemsJson.length > 0) {
          Map? data = itemsJson.first;
          print(data);
          if (data != null) {
            String plate = data['plate'];
            onSuccess(plate);
          } else {
            onFailure(Strings.errorEmpty4);
          }
        } else {
          onFailure(Strings.errorEmpty4);
        }
      } else {
        onFailure(Strings.errorEmpty4);
      }
    } on DioError catch (e) {
      print(e);
      print(e.response);
      onFailure(Strings.errorEmpty4);
    }
  }
}
