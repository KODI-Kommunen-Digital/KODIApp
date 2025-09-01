import 'package:heidi/src/utils/configs/app_env.dart';
import 'package:heidi/src/utils/configs/application.dart';
import 'main.dart';

Future<void> main() async {
  Application.init(
    envDomain: AppEnv.staging.domain,
    envPicturesURL: AppEnv.staging.picturesURL,
    envDefaultPictureURL: AppEnv.staging.defaultPictureURL,
    debugMode: AppEnv.staging.debug,
  );
  mainApp();
}
