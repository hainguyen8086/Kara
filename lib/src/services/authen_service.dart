import 'dart:convert';

import 'package:dio/dio.dart';

class AuthenServices {
  late Dio _dio;
  final String indentify_gateway =
      "https://blooming-depths-89692.herokuapp.com";
  // "https://gatewaybeta.fptshop.com.vn/gateway/identity-api-service";

  AuthenServices() {
    // _dio = Dio(BaseOptions(baseUrl: indentify_gateway, headers: {
    //   "accept": "*/*",
    //   "Content-Type": "application/x-www-form-urlencoded"
    // }));
    // _dio.options.contentType = Headers.formUrlEncodedContentType;
    _dio = Dio(BaseOptions(baseUrl: indentify_gateway));
    // _dio.options.headers['Content-Type'] = 'application/x-www-form-urlencoded';
    _dio.options.headers['Content-Type'] = 'application/x-www-form-urlencoded';
    _dio.options.headers['Connection'] = 'keep-alive';
    _dio.options.headers['User-Agent'] =
        'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.111 Safari/537.36';
    //dio.options.headers['Accept'] = 'application/json';
    _dio.options.headers['Accept-Language'] = 'en-US,en;q=0.9';
    _dio.options.headers['Cache-Control'] = 'max-age=0';

    initializeInterceptors();
  }

  Future<Response> authen(String endpoint) async {
    Response response;
    try {
      FormData formData = FormData.fromMap({
        // 'client_id': 'mobile-client',
        // 'client_secret': 'openid role profile som',
        // 'username': '15261',
        // 'password': 'Abcd#2020',
        // 'grant_type': 'password_otp',
        // 'otp': '490732',
        // 'response_type': 'd',
        'username': 'admin',
        'password': '123456'
      });

      response = await _dio.post(endpoint, data: formData);
      // options: Options(headers: {
      //   "Content-Type": "application/x-www-form-urlencoded",
      //   // "Content-Type": "multipart/form-data",
      //   "Accept": "*/*"
      // }));
      //
    } on DioError catch (e) {
      print("==on_err==:" + e.message);
      throw Exception(e.message);
    }
    return response;
  }

  initializeInterceptors() {
    _dio.interceptors.add(InterceptorsWrapper(
        onError: (DioError error, ErrorInterceptorHandler handler) {
      print(
          'ERROR[${error.response?.statusCode}] => PATH: ${error.requestOptions.path}');
      print('==err======== ${error}');
      return handler.next(error);
    }, onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
      print('REQUEST[${options.method}] => PATH: ${options.path}');
      return handler.next(options);
      // print("${request.method} ${request.path}");
    }, onResponse: (Response response, ResponseInterceptorHandler handler) {
      print(
          'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
      print('data: ${response.data}');
      return handler.next(response);
      // print(response.data);
    }));
  }
}
