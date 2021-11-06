import 'dart:async';
import 'dart:html';

import 'package:dio/dio.dart';

class LoginKaraService {
  late Dio _dio;
  final baseHeroku = "https://blooming-depths-89692.herokuapp.com";

  LoginKaraService() {
    _dio = Dio(BaseOptions(baseUrl: baseHeroku));
    initializeInterceptors();
  }

  Future<Response> getToken(String endpoint) async {
    Response response;
    try {
      // var params = {"phone": "0384150460"};
      var formData = FormData.fromMap({
        'username': 'admin',
        'password': '123456',
      });

      response = await _dio.post(endpoint, data: formData);
    } on DioError catch (e) {
      print(e.message);
      throw Exception(e.message);
    }
    return response;
  }

  Future<HttpRequest> postFormData(String url, Map<String, String> data,
      {bool? withCredentials,
      String? responseType,
      Map<String, String>? requestHeaders,
      void onProgress(ProgressEvent e)?}) {
    var parts = [];
    data.forEach((key, value) {
      parts.add('${Uri.encodeQueryComponent(key)}='
          '${Uri.encodeQueryComponent(value)}');
    });
    var formData = parts.join('&');

    if (requestHeaders == null) {
      requestHeaders = <String, String>{};
    }
    requestHeaders.putIfAbsent('Content-Type',
        () => 'application/x-www-form-urlencoded; charset=UTF-8');

    return request(url,
        method: 'POST',
        withCredentials: withCredentials,
        responseType: responseType,
        requestHeaders: requestHeaders,
        sendData: formData,
        onProgress: onProgress);
  }

  Future<HttpRequest> request(String url,
      {String? method,
      bool? withCredentials,
      String? responseType,
      String? mimeType,
      Map<String, String>? requestHeaders,
      sendData,
      void onProgress(ProgressEvent e)?}) {
    var completer = new Completer<HttpRequest>();

    var xhr = new HttpRequest();
    if (method == null) {
      method = 'GET';
    }
    xhr.open(method, url, async: true);

    if (withCredentials != null) {
      xhr.withCredentials = withCredentials;
    }

    if (responseType != null) {
      xhr.responseType = responseType;
    }

    if (mimeType != null) {
      xhr.overrideMimeType(mimeType);
    }

    if (requestHeaders != null) {
      requestHeaders.forEach((header, value) {
        xhr.setRequestHeader(header, value);
      });
    }

    if (onProgress != null) {
      xhr.onProgress.listen(onProgress);
    }

    xhr.onLoad.listen((e) {
      var status = xhr.status!;
      var accepted = status >= 200 && status < 300;
      var fileUri = status == 0; // file:// URIs have status of 0.
      var notModified = status == 304;
      // Redirect status is specified up to 307, but others have been used in
      // practice. Notably Google Drive uses 308 Resume Incomplete for
      // resumable uploads, and it's also been used as a redirect. The
      // redirect case will be handled by the browser before it gets to us,
      // so if we see it we should pass it through to the user.
      var unknownRedirect = status > 307 && status < 400;

      if (accepted || fileUri || notModified || unknownRedirect) {
        completer.complete(xhr);
      } else {
        completer.completeError(e);
      }
    });

    xhr.onError.listen(completer.completeError);

    if (sendData != null) {
      xhr.send(sendData);
    } else {
      xhr.send();
    }

    return completer.future;
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
