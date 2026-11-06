import 'dart:io';
import 'dart:ui';
import 'package:native_geofence/native_geofence.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../core/analytics/analytics_events.dart';
import '../../../../../core/analytics/analytics_params.dart';
import '../../../../../core/analytics/pending_analytics_queue.dart';
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

    final token = await storage.read(SecureStorageKeys.userToken);
    if (!store.isEnabled || token == null || token.isEmpty) {
      await store.setEnabled(false);
      await registrar.clear();
      return;
    }

    AppStrings.baseUrl = store.serverUrl;
    await S.load(Locale(preferences.getCurrentLanguage()));

    final outcome = await _run(
      transition,
      params,
      preferences,
      storage,
      store,
      registrar,
    );

    if (outcome != AutoAttendanceOutcome.ignored) {
      await LocalAutoAttendanceNotifier().notify(outcome);
      await PendingAnalyticsQueue(preferences).enqueue(
        AnalyticsEvents.autoAttendanceTriggered,
        {
          AnalyticsParams.transition: transition.name,
          AnalyticsParams.outcome: outcome.name,
        },
      );
    }
  }

  static Future<AutoAttendanceOutcome> _run(
    GeofenceTransition transition,
    GeofenceCallbackParams params,
    PreferencesStorage preferences,
    SecureStorage storage,
    AutoAttendancePrefsStore store,
    NativeGeofenceRegistrar registrar,
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

    await _promote();
    try {
      return await handler(
        transition,
        lat: params.location?.latitude,
        lng: params.location?.longitude,
        at: params.triggeredAt ?? DateTime.now(),
      ).timeout(_requestBudget);
    } catch (error) {
      safePrint('Auto attendance failed: $error');
      return AutoAttendanceOutcome.failed;
    } finally {
      await _demote();
    }
  }

  static GeofenceTransition? _transitionOf(GeofenceEvent event) =>
      switch (event) {
        GeofenceEvent.enter => GeofenceTransition.entered,
        GeofenceEvent.exit => GeofenceTransition.exited,
        _ => null,
      };

  static Future<void> _promote() async {
    if (!Platform.isAndroid) return;
    try {
      await NativeGeofenceBackgroundManager.instance.promoteToForeground();
    } catch (error) {
      safePrint('Could not promote to foreground: $error');
    }
  }

  static Future<void> _demote() async {
    if (!Platform.isAndroid) return;
    try {
      await NativeGeofenceBackgroundManager.instance.demoteToBackground();
    } catch (_) {}
  }
}
