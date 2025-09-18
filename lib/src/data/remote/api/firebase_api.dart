import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:heidi/main_dev.dart';
import 'package:heidi/src/data/remote/api/api.dart';
import 'package:heidi/src/data/repository/list_repository.dart';
import 'package:heidi/src/utils/configs/preferences.dart';
import 'package:heidi/src/utils/configs/routes.dart';
import 'package:heidi/src/utils/logging/loggy_exp.dart';

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

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      prefs.setKeyValue(Preferences.pushNotificationsPermission, "authorized");
      try {
        await _firebaseMessaging
            .subscribeToTopic("warnings")
            .timeout(const Duration(seconds: 10));
      } catch (e) {
        logInfo("Warning subscription timedout");
      }
    } else if (settings.authorizationStatus == AuthorizationStatus.denied) {
      prefs.setKeyValue(Preferences.pushNotificationsPermission, "denied");
      try {
        await _firebaseMessaging
            .unsubscribeFromTopic("warnings")
            .timeout(const Duration(seconds: 10));
      } catch (e) {
        logInfo("Warning unsubscription timedout");
      }
    }

    int uId = await getLoggedUserId();
    if (uId > 0) {
      String? token = await FirebaseMessaging.instance.getToken();
      if (token != null) uploadToken(uId, token);
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
    await _firebaseMessaging.subscribeToTopic(topic);
    debugPrint('Topic Subscribed : $topic');
  }

  Future<void> unsubscribeFromTopic(String topic) async {
    await _firebaseMessaging.unsubscribeFromTopic(topic);
    debugPrint('Topic Unsubscribed : $topic');

  }

  Future<void> refreshNotifications() async {
    final pushNotificationsPermission =
        await prefs.getKeyValue(Preferences.pushNotificationsPermission, "0");
    final receiveNotification =
        await prefs.getKeyValue(Preferences.receiveNotification, "true");

    if (pushNotificationsPermission == "authorized" &&
        receiveNotification == "true") {
      await _firebaseMessaging.subscribeToTopic("warnings");
    } else {
      await _firebaseMessaging.unsubscribeFromTopic("warnings");
    }
  }

  Future<void> uploadToken(int userId, String token) async {
    final response = await Api.uploadToken(userId, {"firebaseToken": token});
    logInfo("FCM token upload success: ${response.success}");
  }

  Future<int> getLoggedUserId() async {
    final prefs = await Preferences.openBox();
    final userId = prefs.getKeyValue(Preferences.userId, 0);
    return userId;
  }
}
