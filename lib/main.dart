import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heidi/firebase_options.dart';
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

Future<void> mainApp() async {
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

  await SentryFlutter.init((options) {
    options.dsn =
    'https://d1100c58538e514e0b59f343260bc9a6@o4507264812908544.ingest.de.sentry.io/4508444268888144';
    options.tracesSampleRate = 0.01;
  }, appRunner: () => runApp(GeraApp(prefBox)));

  await MatomoTracker.instance.initialize(
    siteId: '1',
    url: 'https://63inside-app.matomo.cloud/matomo.php',
  );

  await Firebase.initializeApp(
    // options: DefaultFirebaseOptions.currentPlatform,
  );

  await FirebaseApi(globalNavKey, prefBox).initNotifications();
}