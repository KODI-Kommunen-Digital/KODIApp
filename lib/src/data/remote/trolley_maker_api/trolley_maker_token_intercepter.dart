import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:heidi/src/data/model/model_trolley_maker_error_response.dart';
import 'package:heidi/src/utils/configs/preferences.dart';

class TokenInterceptor extends Interceptor {
  final Preferences prefBox;
  final VoidCallback onTokenExpiry;
  TokenInterceptor(this.prefBox, this.onTokenExpiry);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    String token = prefBox.getKeyValue(Preferences.trolleyMakerApiToken, "");
    if (token.isNotEmpty) {
      options.queryParameters.addAll({'retain': '1'});
      options.headers.putIfAbsent('X-API-Token', () => token);
    }
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final newToken = response.headers.value('X-NEW-Token');
    if (newToken != null) {
      prefBox.setKeyValue(Preferences.trolleyMakerApiToken, newToken);
    }
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    try {
      final responseMap =
          jsonDecode(err.response.toString()) as Map<String, dynamic>;
      final errorResponse = TrolleyMakerErrorResponse.fromJson(responseMap);
      final newToken = err.response?.headers.value('X-NEW-Token');
      if ((errorResponse.isInvalidToken() || errorResponse.isExpiredToken()) &&
          newToken == null) {
        onTokenExpiry.call();
      }
      // ignore: empty_catches
    } catch (e) {}
    super.onError(err, handler);
  }
}
