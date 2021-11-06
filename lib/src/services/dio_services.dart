import 'package:dio/dio.dart';

class ServicesDio {
  Dio getDioRequest(String url, {String referer = ''}) {
    var dio = Dio();
    dio.options.headers['Content-Type'] = 'application/x-www-form-urlencoded';
    dio.options.headers['Connection'] = 'keep-alive';
    dio.options.headers['User-Agent'] =
        'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.111 Safari/537.36';
    //dio.options.headers['Accept'] = 'application/json';
    dio.options.headers['Accept-Language'] = 'en-US,en;q=0.9';
    dio.options.headers['Cache-Control'] = 'max-age=0';
    dio.options.maxRedirects = 10;
    dio.options.followRedirects = true;
    return dio;
  }

  Future<String> testAPI() async {
    try {
      const url = 'https://blooming-depths-89692.herokuapp.com/api/auth';
      var dio = getDioRequest(url);
      var formData = FormData.fromMap({
        'username': 'admin',
        'password': '123456',
      });
      var result = await dio.post(url, data: formData);
      print("===ok=======");
      print(result);
      return "OK";
    } catch (e) {
      print("===on_err===: $e");
      return "false";
    }
  }
}
