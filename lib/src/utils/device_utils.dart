import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:heidi/src/utils/configs/application.dart';
import 'package:heidi/src/data/model/model_device.dart';

Future<void> initDevice() async {
  final deviceInfo = DeviceInfoPlugin();
  String deviceId = '';
  String model = '';
  String version = '';
  String type = Platform.isAndroid ? 'android' : 'ios';
  String? fcmToken = await FirebaseMessaging.instance.getToken();

  if (Platform.isAndroid) {
    final info = await deviceInfo.androidInfo;
    deviceId = info.id;
    model = info.model;
    version = info.version.release;
  } else if (Platform.isIOS) {
    final info = await deviceInfo.iosInfo;
    deviceId = info.identifierForVendor ?? '';
    model = info.name;
    version = info.systemVersion;
  }

  Application.device = DeviceModel(
    uuid: deviceId,
    model: model,
    version: version,
    token: fcmToken,
    type: type,
  );
}
