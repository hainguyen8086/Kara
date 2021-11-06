import 'dart:convert';

import 'package:dio/dio.dart';

class ServiceZaloPay {
  late Dio _dio;
  final zaloGW =
      "https://gatewaybeta.fptshop.com.vn/gateway/som-integration-service";
  String token =
      "eyJhbGciOiJSUzI1NiIsImtpZCI6IjYyMzNhNDEwNWFkNjk4ZWE0ODMzMzBlYWZmYmY1NmNmIiwidHlwIjoiSldUIn0.eyJuYmYiOjE2MzU4MzQ3MzcsImV4cCI6MTY2NzM3MDczNywiaXNzIjoiaHR0cHM6Ly9pZGVudGl0eS1iZXRhLmZwdHNob3AuY29tLnZuIiwiYXVkIjpbImh0dHBzOi8vaWRlbnRpdHktYmV0YS5mcHRzaG9wLmNvbS52bi9yZXNvdXJjZXMiLCJub3RpZmljYXRpb24tc2VydmljZSIsInNvbSJdLCJjbGllbnRfaWQiOiJtb2JpbGUtY2xpZW50Iiwic3ViIjoiYjkyODIxMjQtNTdmNC00NDM5LTgxZDUtOTVjNjk4NDA4OTQxIiwiYXV0aF90aW1lIjoxNjM1ODM0NzM3LCJpZHAiOiJsb2NhbCIsInBpY3R1cmUiOiJodHRwczovL2luc2lkZWJldGEuZnB0c2hvcC5jb20udm4vVXBsb2FkL0F2YXRhckVtcGxveWVlLzE1MjYxLmpwZyIsIndhcmVob3VzZSI6IkhDTSAzMDUgVMO0IEhp4bq_biBUaMOgbmgiLCJyb2xlIjpbIlNPTV9FbXBsb3llZSIsIlNPTV9TTSJdLCJuYW1lIjoiMTUyNjEiLCJlbWFpbCI6Ikh1dW5wMkBmcHQuY29tLnZuIiwiaW5zaWRlX2lkIjoiMTQyMjIiLCJlbXBsb3llZV9jb2RlIjoiMTUyNjEiLCJ3YXJlaG91c2VfY29kZSI6IjMwODA4IiwidGl0bGUiOiJUcsaw4bufbmcgcXXhuqNuIGzDvSBj4butYSBow6BuZyIsImZ1bGxfbmFtZSI6Ik5ndXnhu4VuIFBow7pjIEjhu691IiwiZ3JhbnRlZF9wb2xpY2llcyI6IltcIkZSVC5PcmRlckFQSS5PcmRlcnMudmlldHRlbFNlbmRcIixcIkZSVC5PcmRlckFQSS5PcmRlcnMuQ3JlYXRlQmlsbFwiLFwiRlJULk9yZGVyQVBJLk9yZGVycy5DcmVhdGVDYXJkXCIsXCJGUlQuT3JkZXJBUEkuT3JkZXJzLnZpZXR0ZWxUcmFuc2ZlclwiLFwiRlJULk9yZGVyQVBJLk9yZGVycy5tb21vUmVjZWl2ZXJcIixcIkZSVC5PcmRlckFQSS5PcmRlcnMudmlldHRlbFNlYXJjaFwiLFwiRlJULk9yZGVyQVBJLk9yZGVycy5hcHBsZUNhcmVcIixcIkZSVC5PcmRlckFQSS5PcmRlcnMudmlldHRlbFJlY2VpdmVyXCIsXCJGUlQuT3JkZXJBUEkuT3JkZXJzLmNhc2hPdXRNb01vXCIsXCJGUlQuT3JkZXJBUEkuT3JkZXJzLkNyZWF0ZVRvcHVwXCIsXCJGUlQuT3JkZXJBUEkuT3JkZXJzLmtleVNvZnRcIixcIkZSVC5PcmRlckFQSS5PcmRlcnMuQmlsbFNlYXJjaFwiLFwiRlJULk9yZGVyQVBJLk9yZGVycy5DYXJkU2VhcmNoXCIsXCJGUlQuT3JkZXJBUEkuT3JkZXJzLm1vbW9TZW5kXCIsXCJGUlQuT3JkZXJBUEkuT3JkZXJzLmNyZWF0ZU1vTW9CaWxsXCIsXCJGUlQuT3JkZXJBUEkuT3JkZXJzLlRvcHVwU2VhcmNoXCIsXCJGUlQuT3JkZXJBUEkuT3JkZXJzLm1vbW9TZWFyY2hcIixcIkZSVC5PcmRlckFQSS5PcmRlcnMuQ2FyZFRvUG9zXCIsXCJGUlQuT3JkZXJBUEkuT3JkZXJzLkNhbmNlbFwiLFwiRlJULk9yZGVyQVBJLk9yZGVycy5vdGhlckZ1bmN0aW9uc1wiXSIsInNjb3BlIjpbIm9wZW5pZCIsInByb2ZpbGUiLCJyb2xlIiwibm90aWZpY2F0aW9uLXNlcnZpY2UiLCJzb20iLCJvZmZsaW5lX2FjY2VzcyJdLCJhbXIiOlsicGFzc3dvcmRfb3RwIl19.FFhnXUBohJgu-Sbqq9cQkyblBDRLB2pEe7xiSdVLxT0CiMDJEcuinDYZu65LKPHFp4BA0aHH375OjdqmR_eKnEDcMxhPq96rPxmdD417kXxUzfyTsB3F-IcdpEhI7ctXQ96IsT8zQl4cCT4DYirVBCCUcsqShBDvFMP_e0h0XhV4dnbOTb_Spi4bkX2hkNScJwkXjmuaVk_6582pj6rzgZibOz_XnairLcN50FMzbRaDa9FcmXQIuj15nwxmJb4DzWtfsS6gi0difSVJbbaW6hEN1VpZb4pr4edOI6xUh0TPyWBtnHj2M3mzhcn-QlptQrN3pvO-adl_ngCtVLxsEw";

  ServiceZaloPay() {
    _dio = Dio(BaseOptions(
        baseUrl: zaloGW, headers: {"Authorization": "Bearer $token"}));

    initializeInterceptors();
  }

  Future<Response> getUser(String endPoint) async {
    Response response;

    try {
      var params = {"phone": "0384150460"};

      response = await _dio.post(endPoint, data: params);
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
