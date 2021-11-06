import 'package:dio/dio.dart';

class HttpService {
  late Dio _dio;

  final baseUrl1 = "https://reqres.in/";

  HttpService() {
    _dio = Dio(BaseOptions(baseUrl: baseUrl1));

    initializeInterceptors();
  }
  // createService(){
  //   _dio = Dio(BaseOptions(baseUrl: baseUrl1));
  // }

  Future<Response> getRequest(String endPoint) async {
    Response response;

    try {
      response = await _dio.get(endPoint);
    } on DioError catch (e) {
      print(e.message);
      throw Exception(e.message);
    }

    return response;
  }

  initializeInterceptors() {
    _dio.interceptors.add(InterceptorsWrapper(
        onError: (DioError error, ErrorInterceptorHandler handler) {
      print(
          'ERROR[${error.response?.statusCode}] => PATH: ${error.requestOptions.path}');
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
