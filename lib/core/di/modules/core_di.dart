import '../../analytics/api_analytics_tracker.dart';
import '../../analytics/app_analytics.dart';
import '../../analytics/pending_analytics_queue.dart';
import '../../app_startup/remote_config_service.dart';
import '../../app_startup/update_dialog_service.dart';
import '../../app_startup/version_checker.dart';
import '../../analytics/firebase_analytics_service.dart';
import '../../analytics/i_analytics_service.dart';
import '../../review/review_prompt_service.dart';
import '../../../shared/analytics/user_analytics_sync.dart';
import '../../../shared/location/domain/use_cases/resolve_governorate_use_case.dart';
import '../../../shared/location/data/device_position_source.dart';
import '../../../shared/location/data/external_maps_launcher.dart';
import '../../../shared/location/data/location_repo.dart';
import '../../../shared/location/data/place_geocoder.dart';
import '../../../shared/location/domain/repos/i_location_repo.dart';
import '../../../shared/location/domain/use_cases/get_current_location_use_case.dart';
import '../../../shared/location/domain/use_cases/get_location_availability_use_case.dart';
import '../../../shared/location/domain/use_cases/open_in_maps_use_case.dart';
import '../../../shared/location/domain/use_cases/open_location_settings_use_case.dart';
import '../../../shared/location/domain/use_cases/resolve_place_use_case.dart';
import '../../../shared/location/domain/use_cases/search_places_use_case.dart';
import '../../../shared/location/presentation/manager/location_status_cubit.dart';
import '../../../shared/location/presentation/manager/map_location_picker_cubit.dart';
import '../../cache/secure_storage/app_flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../shared/support/data/apis/support_api.dart';
import '../../../shared/support/data/repos/support_repo.dart';
import '../../../shared/support/domain/repos/i_support_repo.dart';
import '../../../shared/support/domain/use_cases/get_support_info_use_case.dart';
import '../../../shared/support/presentation/manager/support_cubit.dart';
import '../../../features/barber/notifications/presentation/services/barber_notification_router.dart';
import '../../../features/merchant/notifications/presentation/services/merchant_notification_router.dart';
import '../../cache/preferences_storage/preferences_storage.dart';
import '../../cache/secure_storage/secure_storage.dart';
import '../../crash_reporting/crashlytics_tool.dart';
import '../../crash_reporting/sentry_tool.dart';
import '../../crash_reporting/vso_crash_reporting_manager.dart';
import '../../notifications/notification_router.dart';
import '../../notifications/notification_service.dart';
import '../../notifications/user_type_notification_router.dart';
import '../../network/dio/dio_factory.dart';
import '../../network/dio/network_service.dart';
import '../../network/interceptors/authorization_interceptor.dart';
import '../../session/session_manager.dart';
import '../sl.dart';

void registerSupport() {
  sl.registerLazySingleton(() => SupportApi(sl()));
  sl.registerLazySingleton<ISupportRepo>(() => SupportRepo(sl()));
  sl.registerLazySingleton(() => GetSupportInfoUseCase(sl()));
  sl.registerLazySingleton(() => SupportCubit(sl()));
  registerLocation();
  registerAnalytics();
}

void registerAnalytics() {
  sl.registerLazySingleton<IAnalyticsService>(() => FirebaseAnalyticsService());
  sl.registerLazySingleton(() => AppAnalytics(sl()));
  sl.registerLazySingleton(() => PendingAnalyticsQueue(sl()));
  sl.registerLazySingleton(() => ReviewPromptService(sl(), sl()));
  sl.registerLazySingleton(() => UserAnalyticsSync(sl(), sl(), sl(), sl()));
  sl.registerLazySingleton(() => ApiAnalyticsTracker(sl(), sl(), sl()));
}

void registerLocation() {
  sl.registerLazySingleton(() => DevicePositionSource(sl()));
  sl.registerLazySingleton(() => PlaceGeocoder());
  sl.registerLazySingleton(() => ExternalMapsLauncher());
  sl.registerLazySingleton(() => OpenInMapsUseCase(sl()));
  sl.registerLazySingleton<ILocationRepo>(() => LocationRepo(sl(), sl(), sl()));
  sl.registerLazySingleton(() => GetCurrentLocationUseCase(sl()));
  sl.registerLazySingleton(() => GetLocationAvailabilityUseCase(sl()));
  sl.registerLazySingleton(() => OpenLocationSettingsUseCase(sl()));
  sl.registerLazySingleton(() => ResolvePlaceUseCase(sl()));
  sl.registerLazySingleton(() => ResolveGovernorateUseCase(sl()));
  sl.registerLazySingleton(() => SearchPlacesUseCase(sl()));
  sl.registerFactory(() => LocationStatusCubit(sl(), sl(), sl()));
  sl.registerFactory(() => MapLocationPickerCubit(sl(), sl(), sl(), sl()));
}

void registerCrashReporting() {
  final manager = VSOCrashReportingManager(sl());
  sl.registerLazySingleton<VSOCrashReportingManager>(() => manager);

  manager.registerCrashReportingTool(CrashlyticsTool());
  manager.registerCrashReportingTool(SentryTool());
  manager.initCrashReportingKeys();
}

Future<void> registerSharedPreferencesStorage() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => PreferencesStorage(sharedPreferences));
}

void registerFlutterSecureStorage() {
  sl.registerLazySingleton(() => SecureStorage(appFlutterSecureStorage));
}

void registerAppStartup() {
  sl.registerLazySingleton<IRemoteConfigService>(
    () => FirebaseRemoteConfigService(),
  );
  sl.registerLazySingleton(() => CupertinoUpdateDialogService());
  sl.registerLazySingleton(
    () => VersionChecker(sl(), sl(), sl<VSOCrashReportingManager>()),
  );
}

void registerSessionManager() {
  sl.registerLazySingleton(() => SessionManager(sl(), sl()));
}

void registerDioService() {
  sl.registerLazySingleton(
    () => AuthorizationInterceptor(
      sl<SecureStorage>(),
      sl<PreferencesStorage>(),
      sl<SessionManager>().emitUnauthorized,
    ),
  );

  sl.registerLazySingleton(
    () =>
        NetworkService(DioFactory.create(sl<AuthorizationInterceptor>(), sl())),
  );
}

void registerNotificationService() {
  final service = NotificationService();
  final navigator = NotificationNavigator();

  service.setNavigator(navigator);
  service.setupNotifications();

  sl.registerSingleton<NotificationNavigator>(navigator);
  sl.registerSingleton<NotificationService>(service);
}

void registerNotificationRouter() {
  sl.registerLazySingleton<MerchantNotificationRouter>(
    () => MerchantNotificationRouter(),
  );
  sl.registerLazySingleton<BarberNotificationRouter>(
    () => BarberNotificationRouter(),
  );
  sl.registerLazySingleton<NotificationRouter>(
    () => UserTypeNotificationRouter(),
  );
}
