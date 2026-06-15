import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppEnv {
  final String name;
  final String envFilePath;
  final bool debug;

  const AppEnv({
    required this.name,
    required this.envFilePath,
    this.debug = true,
  });

  String get domain => dotenv.env['DEFAULT_API_URL'] ?? '';
  String get picturesURL => dotenv.env['IMAGE_URL'] ?? '';
  String get defaultPictureURL => dotenv.env['DEFAULT_PROFILE_IMAGE_URL'] ?? '';

  static const staging = AppEnv(
    name: "staging",
    envFilePath: "assets/env/staging/.envGera",
    debug: true,
  );

  static const production = AppEnv(
    name: "production",
    envFilePath: "assets/env/production/.envGera",
    debug: false,
  );
}
