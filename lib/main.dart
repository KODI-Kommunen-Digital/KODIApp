import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heidi/gera_app.dart';
import 'package:heidi/src/data/remote/api/firebase_api.dart';
import 'package:heidi/src/utils/adapters/formdata_adapter.dart';
import 'package:heidi/src/utils/configs/preferences.dart';
import 'package:heidi/src/utils/heidi_bloc_observer.dart';
import 'package:heidi/src/utils/logging/bloc_logger.dart';
import 'package:heidi/src/utils/logging/crashlytics_log_printer.dart';
import 'package:heidi/src/utils/logging/drift_logger.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:loggy/loggy.dart';
import 'package:matomo_tracker/matomo_tracker.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:upgrader/upgrader.dart';

Future<void> mainApp({required FirebaseOptions firebaseOptions}) async {
  await Hive.initFlutter();
  Hive.registerAdapter(FormDataAdapter());
  WidgetsFlutterBinding.ensureInitialized();
  Loggy.initLoggy(
    logPrinter: FirebaseCrashlyticsLogPrinter(),
    filters: [
      BlacklistFilter([
        BlocLoggy,
        DriftLoggy,
      ])
    ],
  );
  await Hive.initFlutter();
  final prefBox = await Preferences.openBox();

  Bloc.observer = HeidiBlocObserver();
  await Upgrader.clearSavedSettings();

  await SentryFlutter.init(
        (options) {
      options.dsn =
      'https://d1100c58538e514e0b59f343260bc9a6@o4507264812908544.ingest.de.sentry.io/4508444268888144';
      options.tracesSampleRate = 0.01;
      // Configure Firebase integrations if needed
      // options.addIntegration(FirebaseIntegration());
    },
    appRunner: () => runApp(GeraApp(prefBox)),
  );


  if (Platform.isAndroid) {
    await Firebase.initializeApp(
        options: firebaseOptions);
    debugPrint("Firebase project id: ${Firebase.app().options.projectId}");
  } else {
    try {
      await Firebase.initializeApp();
      debugPrint("Firebase project id: ${Firebase.app().options.projectId}");
    } on FirebaseException catch (e) {
      debugPrint("Firebase already initialized: $e");
    }
  }

  await MatomoTracker.instance.initialize(
    siteId: '1',
    url: 'https://63inside-app.matomo.cloud/matomo.php',
  );

  await FirebaseApi(globalNavKey, prefBox).initNotifications();
}