import 'dart:io';
import 'package:budge_up/utils/preference_helper.dart';
import 'package:budge_up/utils/strings.dart';
import 'package:http_parser/http_parser.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ScannerApi {
  Future<void> scan({
    required File image,
    required Function(String) onSuccess,
    required Function(String) onFailure,
  }) async {
    BaseOptions options = new BaseOptions(
      baseUrl: 'https://budgeup.ru/api/v1/',
      headers: {
        "accept": 'application/json',
      },
    );

    var _token = await PreferenceHelper().token;

    if (_token.length > 0) {
      // print(_token);
      options.headers['Authorization'] = 'Bearer $_token';
    }
    Dio dio = Dio(options);
    dio.interceptors.add(PrettyDioLogger());
    MultipartFile multipartFile = MultipartFile.fromFileSync(image.path,
        filename: image.path, contentType: MediaType("image", "png"));

    FormData formData = FormData.fromMap({
      "photo": multipartFile,
    });

    print(formData.fields);
    try {
      Response response = await dio.post('scanner', data: formData);
      print(response.data);
      if (response.statusCode == 201 || response.statusCode == 200) {
        if (response.data != null) {
          String number = response.data['number'] ?? "";
          onSuccess(number);
        } else {
          onFailure(Strings.errorEmpty4);
        }
      } else {
        onFailure(Strings.errorEmpty4);
      }
    } on DioError catch (e) {
      print(e);
      print(e.response);
      if (e.response != null) {
        String error = e.response!.data['error'] ?? "";
        if (error.length == 0) {
          String errorDesc = e.response!.data['error_description'] ?? "";
          onFailure(errorDesc);
        } else {
          onFailure(error);
        }
      } else {
        onFailure(Strings.errorEmpty4);
      }
    }
  }
}
