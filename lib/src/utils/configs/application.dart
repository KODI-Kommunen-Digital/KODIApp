import 'package:heidi/src/data/model/model_device.dart';
import 'package:heidi/src/data/model/model_setting.dart';

class Application {
  static bool debug = true;
  static late String domain;
  static late String picturesURL;
  static late String defaultPicturesURL;

  static DeviceModel? device;
  static SettingModel setting = SettingModel.fromDefault();

  static final Application _instance = Application._internal();

  factory Application() {
    return _instance;
  }

  Application._internal();

  static void init({
    required String envDomain,
    required String envPicturesURL,
    required String envDefaultPictureURL,
    bool debugMode = true,
  }) {
    debug = debugMode;
    domain = envDomain;
    picturesURL = envPicturesURL;
    defaultPicturesURL = envDefaultPictureURL;
  }
}
