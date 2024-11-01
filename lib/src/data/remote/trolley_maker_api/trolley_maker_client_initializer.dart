import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:heidi/src/data/remote/trolley_maker_api/trolley_maker_client_api.dart';

class TrolleyMakerClientInitializer {

  static TrolleyMakerClientApi get() {
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
          'X-API-Key': xApiKey
        },
        baseUrl: baseUrl,
      ),
    );
    // dio.interceptors.add(TokenInterceptor());
    // dio.interceptors.add(PrettyDioLogger());
    return TrolleyMakerClientApi(dio);
  }
}
