import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:heidi/src/staging/firebase_options.dart';
import 'package:heidi/src/utils/configs/app_env.dart';
import 'package:heidi/src/utils/configs/application.dart';
import 'main.dart';

Future<void> main() async {
  await dotenv.load(fileName: AppEnv.staging.envFilePath);
  Application.init(
    envDomain: AppEnv.staging.domain,
    envPicturesURL: AppEnv.staging.picturesURL,
    envDefaultPictureURL: AppEnv.staging.defaultPictureURL,
    debugMode: AppEnv.staging.debug,
  );
  mainApp(firebaseOptions: StagingDefaultFirebaseOptions.currentPlatform);
}
