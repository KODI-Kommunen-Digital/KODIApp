import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:heidi/src/utils/logging/loggy_exp.dart';
import 'package:http/http.dart';

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  logDebug("Title: ${message.notification?.title}");
  logDebug("Body: ${message.notification?.body}");
  logDebug("Payload: ${message.data}");
}

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;

  void handleMessage(RemoteMessage? message) {
    //Logic to navigate to post, implement later
    if (message != null) {}
  }

  static Future<void> sendPushNotification(
      String notificationTitle, String notificationBody) async {
    try {
      final body = {
        "to": "/topics/warnings",
        //"dKZfGFfcQ4CjEEPimIXhIQ:APA91bEFy6zZW06lxA9-MObJeOajlIceS955r8hfm1gGJ2VT1jPbBFfRhvf0VdrsrWDDkDAKXW1idHfeiRc4ikJo5puDG_HPuNjUb8-s7ZkecoJUR9Oc6MUzNqvkfFY5k83Fx0_Q12ho",
        "notification": {
          "title": notificationTitle, //our name should be send
          "body": notificationBody,
        }
      };

      var url = Uri.parse("https://fcm.googleapis.com/fcm/send");
      var response = await post(url,
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
            HttpHeaders.authorizationHeader:
                "key=AAAAmbJzFR8:APA91bEck_SIniItJ8pj6giDIqKOS8v-qv0Q0V0tNSzo_-0j_j21u5lo-hLMAg2V5_I0CUvhaEQfXi8hZ9HTul04bvvg69PWs3NpwXi0JlY71NAIAhz9bBX31658TaL4YvSHEP0lC7Y8"
          },
          body: jsonEncode(body));

      logError(response.statusCode);
    } catch (e) {
      logError("Failed to send notification");
    }
  }

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();

    //FCM Token for testing
    try {
      final fCMToken = await _firebaseMessaging.getToken();
      print("Token: $fCMToken");
    } catch (e) {
      logError("Couldn't retrieve token: $e");
    }
    //End FCM Token

    await _firebaseMessaging.subscribeToTopic("warnings");

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
            alert: true, badge: true, sound: true);

    _firebaseMessaging.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  }
}
