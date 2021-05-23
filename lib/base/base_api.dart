import 'package:dio/dio.dart';

class BaseApi {
  Future<Dio> get dio async {
    BaseOptions options = new BaseOptions(
      connectTimeout: 5000,
      receiveTimeout: 3000,
      baseUrl: 'https://budgeup.ru/api/',
      headers: {
        "accept": 'application/json',
      },
    );
    // options.headers["content-language"] = "ru";
    // options.headers["Accept-Language"] = "ru";
    // if (_token == null) {
    //   _token = await _preferenceHelper.token;
    //   print(_token);
    // }
    // if (_token != null && _token.length > 0) {
    //   options.headers['Authorization'] = 'Bearer $_token';
    // }

    Dio d = Dio(options);
    return d;
  }
}
