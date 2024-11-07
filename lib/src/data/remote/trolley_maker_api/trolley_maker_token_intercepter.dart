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
      options.headers.putIfAbsent('X-API-Token', () => token);
    }
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    try {
      final responseMap =
          jsonDecode(err.response.toString()) as Map<String, dynamic>;
      final errorResponse = TrolleyMakerErrorResponse.fromJson(responseMap);
      if (errorResponse.isInvalidToken()) {
        onTokenExpiry.call();
      }
      // ignore: empty_catches
    } catch (e) {}
    super.onError(err, handler);
  }
}
