import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:heidi/src/data/remote/api/api.dart';
import 'package:heidi/src/data/repository/list_repository.dart';
import 'package:heidi/src/utils/configs/preferences.dart';
import 'package:heidi/src/utils/configs/routes.dart';
import 'package:heidi/src/utils/logging/loggy_exp.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';

Future<void> handleBackgroundMessage(RemoteMessage? message) async {}

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;
  final GlobalKey<NavigatorState> navigatorKey;
  final Preferences prefs;

  FirebaseApi(this.navigatorKey, this.prefs);

  Future<void> handleMessageOnUserInteraction(RemoteMessage? message) async {
    if (message != null) {
      if (message.data["forumId"] != null) {
        final int cityId = int.parse(message.data["cityId"]);

        navigatorKey.currentState?.pushNamed(
          Routes.listGroups,
          arguments: {'id': cityId, 'title': 'Gruppen'},
        );
      } else {
        final item = await ListRepository.loadProduct(
            int.parse(message.data["cityId"]), int.parse(message.data["id"]));
        if (item != null) {
          navigatorKey.currentState
              ?.pushNamed(Routes.productDetail, arguments: item);
        }
      }
    }
  }

  Future<void> handleForegroundNotification(RemoteMessage message) async {
    await _firebaseMessaging.setForegroundNotificationPresentationOptions(
      alert: false,
      badge: false,
      sound: false,
    );
  }

  Future<void> initNotifications() async {
    // Set foreground notification options immediately
    await _firebaseMessaging.setForegroundNotificationPresentationOptions(
      alert: false,
      badge: false,
      sound: false,
    );

    // Request permissions asynchronously
    _requestPermissions();

    // Set up message handlers
    _firebaseMessaging.getInitialMessage().then(handleMessageOnUserInteraction);
    FirebaseMessaging.onMessage.listen(handleForegroundNotification);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessageOnUserInteraction);
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);

    // Perform non-essential tasks after a delay
    Future.delayed(const Duration(seconds: 1), () {
      _initializeSubscriptions();
      _uploadUserToken();
    });
  }

  Future<void> _requestPermissions() async {
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
    );

    String permissionStatus =
        settings.authorizationStatus == AuthorizationStatus.authorized
            ? "authorized"
            : settings.authorizationStatus == AuthorizationStatus.denied
                ? "denied"
                : "0";
    await prefs.setKeyValue(
        Preferences.pushNotificationsPermission, permissionStatus);
  }

  Future<void> _initializeSubscriptions() async {
    final pushNotificationsPermission =
        await prefs.getKeyValue(Preferences.pushNotificationsPermission, "0");
    final receiveNotification =
        await prefs.getKeyValue(Preferences.receiveNotification, "true");

    if (pushNotificationsPermission == "authorized" &&
        receiveNotification == "true") {
      await _subscribeToAllForumChats();
      await _firebaseMessaging.subscribeToTopic("warnings");
    } else {
      await _unsubscribeFromAllForumChats();
      await _firebaseMessaging.unsubscribeFromTopic("warnings");
    }
  }

  Future<void> _uploadUserToken() async {
    int uId = await getLoggedUserId();
    if (uId > 0) {
      String? token = await FirebaseMessaging.instance.getToken();
      if (token != null) uploadToken(uId, token);
    }
  }

  Future<void> subscribeToTopic(String topic) async {
    await _firebaseMessaging.subscribeToTopic(topic);
  }

  Future<void> unsubscribeFromTopic(String topic) async {
    await _firebaseMessaging.unsubscribeFromTopic(topic);
  }

  Future<void> refreshNotifications() async {
    final pushNotificationsPermission =
        await prefs.getKeyValue(Preferences.pushNotificationsPermission, "0");
    final receiveNotification =
        await prefs.getKeyValue(Preferences.receiveNotification, "true");

    if (pushNotificationsPermission == "authorized" &&
        receiveNotification == "true") {
      await _subscribeToAllForumChats();
      await _firebaseMessaging.subscribeToTopic("warnings");
    } else {
      await _unsubscribeFromAllForumChats();
      await _firebaseMessaging.unsubscribeFromTopic("warnings");
    }
  }

  Future<void> _unsubscribeFromAllForumChats() async {
    final List<String> forumChatTopics = await _getForumChatTopics();
    for (String topic in forumChatTopics) {
      await _firebaseMessaging.unsubscribeFromTopic(topic);
      logInfo("Unsubscribed from forum chat topic: $topic");
    }
  }

  Future<void> _subscribeToAllForumChats() async {
    final List<String> forumChatTopics = await _getForumChatTopics();
    for (String topic in forumChatTopics) {
      await _firebaseMessaging.subscribeToTopic(topic);
      logInfo("Subscribed to forum chat topic: $topic");
    }
  }

  Future<List<String>> _getForumChatTopics() async {
    final prefs = await Preferences.openBox();
    final List<String>? forumChatTopics =
        prefs.getKeyValue(Preferences.forumChatTopics, <String>[]);
    return forumChatTopics ?? <String>[];
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

  Future<void> initRemoteConfig() async {
    final FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;
    try {
      await remoteConfig.setConfigSettings(RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 10),
        minimumFetchInterval: const Duration(seconds: 10),
      ));
      await remoteConfig.fetchAndActivate();
      final pressigAppleLink = remoteConfig.getString('pressigAppleLink');
      final pressigAndroidLink = remoteConfig.getString('pressigAndroidLink');
      final schneckenloheAppleLink =
          remoteConfig.getString('schneckenloheAppleLink');
      final schneckenloheAndroidLink =
          remoteConfig.getString('schneckenloheAndroidLink');
      final stockheimAppleLink = remoteConfig.getString('stockheimAppleLink');
      final stockheimAndroidLink =
          remoteConfig.getString('stockheimAndroidLink');
    } catch (exception) {
      logError('Unable to fetch remote config: $exception');
    }
  }
}
