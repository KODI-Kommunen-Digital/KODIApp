import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:heidi/main_dev.dart';
import 'package:heidi/src/data/model/model.dart';
import 'package:heidi/src/data/remote/api/api.dart';
import 'package:heidi/src/data/repository/list_repository.dart';
import 'package:heidi/src/utils/common.dart';
import 'package:heidi/src/utils/configs/preferences.dart';
import 'package:heidi/src/utils/configs/routes.dart';
import 'package:heidi/src/utils/logging/loggy_exp.dart';

import '../../repository/waste_calendar_repository.dart';

Future<void> handleBackgroundMessage(RemoteMessage? message) async {}

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;
  final Preferences prefs;

  FirebaseApi(globalNavKey, this.prefs);

  Future<void> handleMessageOnUserInteraction(RemoteMessage? message) async {
    if (message != null) {
      if (message.notification?.title == "Müllabholung") {
        globalNavKey.currentState?.pushNamed(Routes.wasteCalendar);
      }
      final item = await ListRepository.loadProduct(
          int.parse(message.data["cityId"]), int.parse(message.data["id"]));
      if (item != null) {
        globalNavKey.currentState
            ?.pushNamed(Routes.productDetail, arguments: item);
      }
    }
  }

  Future<void> handleForegroundNotification(RemoteMessage message) async {
    logInfo(
        "Notification received in foreground: ${message.notification?.title}");
  }

  Future<void> initNotifications() async {
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
    );

    bool isFCMTokenRegistered = prefs.getBool(
        Preferences.isFCMTokenRegistered);

    if(!isFCMTokenRegistered) {
      String? token = await FirebaseMessaging.instance.getToken();
      if (token != null) registerDevice(token);
    }

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      prefs.setKeyValue(Preferences.pushNotificationsPermission, "authorized");
      try {
        await _firebaseMessaging
            .subscribeToTopic("warnings")
            .timeout(const Duration(seconds: 10));
        if(isFCMTokenRegistered) {
          subscribeForWasteNotification(true);
        }
      } catch (e) {
        logInfo("Warning subscription timedout");
      }
    } else if (settings.authorizationStatus == AuthorizationStatus.denied) {
      prefs.setKeyValue(Preferences.pushNotificationsPermission, "denied");
      try {
        await _firebaseMessaging
            .unsubscribeFromTopic("warnings")
            .timeout(const Duration(seconds: 10));
        if(isFCMTokenRegistered) {
          subscribeForWasteNotification(false);
        }
      } catch (e) {
        logInfo("Warning unsubscription timedout");
      }
    }

    int uId = await getLoggedUserId();
    if (uId > 0) {
      String? token = await FirebaseMessaging.instance.getToken();
      if (token != null){
        uploadToken(uId, token);
        registerDevice(token);
      }
    }

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
            alert: true, badge: true, sound: true);

    _firebaseMessaging.getInitialMessage().then(handleMessageOnUserInteraction);
    FirebaseMessaging.onMessage.listen(handleForegroundNotification);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessageOnUserInteraction);
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  }

  Future<void> subscribeToTopic(String topic) async {
    _firebaseMessaging.subscribeToTopic(topic);
    debugPrint('Topic Subscribed : $topic');
  }

  Future<void> unsubscribeFromTopic(String topic) async {
    _firebaseMessaging.unsubscribeFromTopic(topic);
    debugPrint('Topic Unsubscribed : $topic');

  }

  Future<void> refreshNotifications() async {
    final pushNotificationsPermission =
    await prefs.getKeyValue(
        Preferences.pushNotificationsPermission, "0");

    final receiveNotification =
    await prefs.getKeyValue(
        Preferences.receiveNotification, "true");

    final futures = <Future>[];

    if (pushNotificationsPermission == "authorized" &&
        receiveNotification == "true") {
      futures.add(_firebaseMessaging.subscribeToTopic("warnings"));
    } else {
      futures.add(_firebaseMessaging.unsubscribeFromTopic("warnings"));
    }

    await Future.wait(futures);
  }

  Future<void> uploadToken(int userId, String token) async {
    final response = await Api.uploadToken(userId, {"firebaseToken": token});
    logInfo("FCM token upload success: ${response.success}");
  }


  Future<void> registerDevice(String token) async {
    DeviceModel? deviceModel = await Utils.getDeviceInfo();
    String? appVersion = await Utils.getAppVersion();
    if(deviceModel!=null) {
      String deviceId = deviceModel.uuid;
      await prefs.setKeyValue(Preferences.deviceId, deviceId);
      String deviceType = deviceModel.model == "Android" ? "android" : "ios";
      final params = {
        "deviceId": deviceId,
        "fcmToken": token,
        "deviceType": deviceType,
        "appVersion": appVersion
      };
      final response = await Api.registerDeviceForWasteNotifications(params);
      await prefs.setBool(Preferences.isFCMTokenRegistered, true);
      logInfo("FCM token register success: ${response.success}");
    }
  }

  Future<void> subscribeForWasteNotification(bool isActive) async {
    DeviceModel? deviceModel = await Utils.getDeviceInfo();
    String deviceId = await prefs.getKeyValue(
        Preferences.deviceId, deviceModel != null ? deviceModel.uuid : "");
    final params = {
        "isActive": isActive
      };
      final response =
          await Api.subscribeForWasteNotification(deviceId, params);
      logInfo("Waste calendar notifications subscription updated: ${response.success}");
  }

  Future<int> getLoggedUserId() async {
    final prefs = await Preferences.openBox();
    final userId = prefs.getKeyValue(Preferences.userId, 0);
    return userId;
  }
}
