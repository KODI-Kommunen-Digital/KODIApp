import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:heidi/src/utils/configs/app_env.dart';
import 'package:heidi/src/utils/configs/application.dart';
import 'main.dart';
import 'src/production/firebase_options.dart';

Future<void> main() async {
  await dotenv.load(fileName: AppEnv.production.envFilePath);
  Application.init(
    envDomain: AppEnv.production.domain,
    envPicturesURL: AppEnv.production.picturesURL,
    envDefaultPictureURL: AppEnv.production.defaultPictureURL,
    debugMode: AppEnv.production.debug,
  );
  mainApp(firebaseOptions: ProductionDefaultFirebaseOptions.currentPlatform);
}
