import 'dart:ui';
import 'package:native_geofence/native_geofence.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../core/cache/preferences_storage/preferences_storage.dart';
import '../../../../../core/cache/secure_storage/app_flutter_secure_storage.dart';
import '../../../../../core/cache/secure_storage/secure_storage.dart';
import '../../../../../core/constants/strings.dart';
import '../../../../../core/helpers/safe_print.dart';
import '../../../../../core/network/dio/dio_factory.dart';
import '../../../../../core/network/dio/network_service.dart';
import '../../../../../core/network/interceptors/authorization_interceptor.dart';
import '../../../../../generated/l10n.dart';
import '../../../attendance/data/apis/barber_attendance_api.dart';
import '../../../attendance/data/repos/barber_attendance_repo.dart';
import '../../../attendance/domain/use_cases/check_in_attendance_use_case.dart';
import '../../../attendance/domain/use_cases/check_out_attendance_use_case.dart';
import '../../../attendance/domain/use_cases/get_current_attendance_use_case.dart';
import '../../domain/entities/auto_attendance_outcome.dart';
import '../../domain/entities/geofence_transition.dart';
import '../../domain/use_cases/handle_geofence_transition_use_case.dart';
import '../services/auto_attendance_prefs_store.dart';
import '../services/local_auto_attendance_notifier.dart';
import '../services/native_geofence_registrar.dart';
import 'auto_attendance_reporter.dart';
import 'foreground_promotion.dart';
import 'shop_presence_background.dart';

@pragma('vm:entry-point')
Future<void> autoAttendanceGeofenceCallback(
  GeofenceCallbackParams params,
) async {
  DartPluginRegistrant.ensureInitialized();
  await AutoAttendanceBackground.handle(params);
}

class AutoAttendanceBackground {
  const AutoAttendanceBackground._();

  static const _requestBudget = Duration(seconds: 40);

  static Future<void> handle(GeofenceCallbackParams params) async {
    final transition = _transitionOf(params.event);
    if (transition == null) return;

    final preferences = PreferencesStorage(
      await SharedPreferences.getInstance(),
    );
    await preferences.reload();

    final store = AutoAttendancePrefsStore(preferences);
    final registrar = NativeGeofenceRegistrar(autoAttendanceGeofenceCallback);
    final storage = SecureStorage(appFlutterSecureStorage);

    if (!store.isEnabled) {
      await registrar.clear();
      return;
    }

    final token = await storage.read(SecureStorageKeys.userToken);
    if (token == null || token.isEmpty) return;

    AppStrings.baseUrl = store.serverUrl;
    await S.load(Locale(preferences.getCurrentLanguage()));

    final notifier = LocalAutoAttendanceNotifier(
      diagnostic: store.serverUrl == AppStrings.devBaseUrl,
    );
    await notifier.announceReceived(transition);

    final reporter = AutoAttendanceReporter(notifier, preferences, transition);
    final outcome = await _run(
      transition,
      params,
      preferences,
      storage,
      store,
      registrar,
      reporter,
    );

    if (outcome != AutoAttendanceOutcome.needsTracking) {
      await reporter.report(outcome);
    }
  }

  static Future<AutoAttendanceOutcome> _run(
    GeofenceTransition transition,
    GeofenceCallbackParams params,
    PreferencesStorage preferences,
    SecureStorage storage,
    AutoAttendancePrefsStore store,
    NativeGeofenceRegistrar registrar,
    AutoAttendanceReporter reporter,
  ) async {
    final network = NetworkService(
      DioFactory.createBare(
        AuthorizationInterceptor(storage, preferences, () {}),
        timeout: const Duration(seconds: 20),
      ),
    );
    final repo = BarberAttendanceRepo(BarberAttendanceApi(network));
    final handler = HandleGeofenceTransitionUseCase(
      GetCurrentAttendanceUseCase(repo),
      CheckInAttendanceUseCase(repo),
      CheckOutAttendanceUseCase(repo),
      store,
      registrar,
    );

    await ForegroundPromotion.promote();
    try {
      final outcome = await handler(
        transition,
        lat: params.location?.latitude,
        lng: params.location?.longitude,
      ).timeout(_requestBudget);

      if (outcome != AutoAttendanceOutcome.needsTracking) return outcome;

      await reporter.report(outcome);
      await ShopPresenceBackground.run(
        repo: repo,
        store: store,
        onOutcome: reporter.report,
      );
      return AutoAttendanceOutcome.needsTracking;
    } catch (error) {
      safePrint('Auto attendance failed: $error');
      return AutoAttendanceOutcome.failed;
    } finally {
      await ForegroundPromotion.demote();
    }
  }

  static GeofenceTransition? _transitionOf(GeofenceEvent event) =>
      switch (event) {
        GeofenceEvent.enter => GeofenceTransition.entered,
        GeofenceEvent.exit => GeofenceTransition.exited,
        _ => null,
      };
}
