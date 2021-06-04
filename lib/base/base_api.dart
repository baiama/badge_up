import 'package:budge_up/utils/preference_helper.dart';
import 'package:dio/dio.dart';

class BaseApi {
  Future<Dio> get dio async {
    BaseOptions options = new BaseOptions(
      connectTimeout: 5000,
      receiveTimeout: 3000,
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

    Dio d = Dio(options);
    return d;
  }
}
