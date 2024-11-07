import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class ApiLoggerInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (kDebugMode) {
      print('*** API Request ***');
      print('URI: ${options.uri}');
      print('Method: ${options.method}');
      print('Headers: ${options.headers}');
      print('Request Data: ${options.data}');
    }
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (kDebugMode) {
      print('*** API Response ***');
      print('URI: ${response.requestOptions.uri}');
      print('Status Code: ${response.statusCode}');
      print('Data: ${response.data}');
    }
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (kDebugMode) {
      print('*** API Error ***');
      print('URI: ${err.requestOptions.uri}');
      print('Error: ${err.message}');
      if (err.response != null) {
        print('Status Code: ${err.response?.statusCode}');
        print('Error Data: ${err.response?.data}');
      }
    }
    super.onError(err, handler);
  }
}
