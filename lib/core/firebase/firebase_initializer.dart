import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';

import '../helpers/safe_print.dart';

class FirebaseInitializer {
  const FirebaseInitializer._();

  static Future<void> init(FirebaseOptions options) async {
    try {
      await Firebase.initializeApp(options: options);
      _attachErrorHandlers();
    } catch (error, stackTrace) {
      safePrint('Firebase init failed: $error\n$stackTrace');
    }
  }

  static void _attachErrorHandlers() {
    final crashlytics = FirebaseCrashlytics.instance;

    FlutterError.onError = (details) {
      FlutterError.presentError(details);
      crashlytics.recordFlutterFatalError(details);
    };

    PlatformDispatcher.instance.onError = (error, stackTrace) {
      crashlytics.recordError(error, stackTrace, fatal: true);
      return true;
    };
  }
}
