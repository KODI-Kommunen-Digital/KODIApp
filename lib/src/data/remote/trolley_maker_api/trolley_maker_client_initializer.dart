import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:heidi/src/data/remote/trolley_maker_api/trolley_maker_api_logger.dart';
import 'package:heidi/src/data/remote/trolley_maker_api/trolley_maker_client_api.dart';
import 'package:heidi/src/data/remote/trolley_maker_api/trolley_maker_token_intercepter.dart';
import 'package:heidi/src/utils/configs/preferences.dart';

class TrolleyMakerClientInitializer {
  static TrolleyMakerClientApi get(
      Preferences prefBox, VoidCallback onTokenExpiry) {
    var baseUrl = dotenv.env['TROLLEY_MAKER_BASE_URL']!;
    var xApiKey = dotenv.env['TROLLEY_MAKER_X_API_KEY']!;
    const duration = Duration(seconds: 20000);
    //dio retrofit
    final Dio dio = Dio(
      BaseOptions(
        connectTimeout: duration,
        sendTimeout: duration,
        receiveTimeout: duration,
        headers: {
          'accept': 'application/json',
          'content-type': 'application/json',
          'exchange-language': 'en_US',
          'X-API-Key': xApiKey,
        },
        baseUrl: baseUrl,
      ),
    );
    dio.interceptors.add(TokenInterceptor(prefBox, () async {
      await prefBox.deleteKey(Preferences.trolleyMakerApiToken);
      onTokenExpiry.call();
    }));
    dio.interceptors.add(PrettyDioLogger());
    return TrolleyMakerClientApi(dio);
  }
}
