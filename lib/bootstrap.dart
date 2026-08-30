import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'app.dart';
import 'core/cache/preferences_storage/preferences_storage.dart';
import 'core/constants/strings.dart';
import 'core/di/services_locator.dart';
import 'core/firebase/firebase_initializer.dart';
import 'core/helpers/app_bloc_observer.dart';
import 'env/env.dart';
import 'env/flavor.dart';

Future<void> bootstrap(Flavor flavor, FirebaseOptions firebaseOptions) async {
  WidgetsFlutterBinding.ensureInitialized();

  currentFlavor = flavor;
  AppStrings.baseUrl = isDevEnvironment()
      ? AppStrings.devBaseUrl
      : AppStrings.prodBaseUrl;

  await FirebaseInitializer.init(firebaseOptions);

  Bloc.observer = AppBlocObserver();

  await ServicesLocator().init();

  await initializeDateFormatting(
    sl<PreferencesStorage>().getCurrentLanguage(),
  );

  runApp(const AyezAhlaqApp());
}
