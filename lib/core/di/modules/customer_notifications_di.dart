import '../../../features/customer/device_token/data/apis/customer_device_token_api.dart';
import '../../../features/customer/device_token/data/repos/customer_device_token_repo.dart';
import '../../../features/customer/device_token/domain/repos/i_customer_device_token_repo.dart';
import '../../../features/customer/device_token/domain/use_cases/register_customer_device_token_use_case.dart';
import '../../../features/customer/device_token/domain/use_cases/unregister_all_customer_device_tokens_use_case.dart';
import '../../../features/customer/device_token/presentation/services/customer_device_token_sync_service.dart';
import '../../../features/customer/notifications/data/apis/customer_notifications_api.dart';
import '../../../features/customer/notifications/data/repos/customer_notifications_repo.dart';
import '../../../features/customer/notifications/domain/repos/i_customer_notifications_repo.dart';
import '../../../features/customer/notifications/domain/use_cases/get_customer_notifications_use_case.dart';
import '../../../features/customer/notifications/domain/use_cases/get_customer_unseen_notifications_count_use_case.dart';
import '../../../features/customer/notifications/domain/use_cases/mark_all_customer_notifications_seen_use_case.dart';
import '../../../features/customer/notifications/domain/use_cases/mark_customer_notification_clicked_use_case.dart';
import '../../../features/customer/notifications/presentation/manager/customer_notifications_cubit.dart';
import '../../../features/customer/notifications/presentation/services/customer_notification_router.dart';
import '../sl.dart';

void registerCustomerDeviceToken() {
  sl.registerLazySingleton(() => CustomerDeviceTokenApi(sl()));
  sl.registerLazySingleton<ICustomerDeviceTokenRepo>(
    () => CustomerDeviceTokenRepo(sl()),
  );
  sl.registerLazySingleton(() => RegisterCustomerDeviceTokenUseCase(sl()));
  sl.registerLazySingleton(
    () => UnregisterAllCustomerDeviceTokensUseCase(sl()),
  );
  sl.registerLazySingleton(
    () => CustomerDeviceTokenSyncService(sl(), sl(), sl()),
  );
}

void registerCustomerNotifications() {
  sl.registerLazySingleton(() => CustomerNotificationsApi(sl()));
  sl.registerLazySingleton<ICustomerNotificationsRepo>(
    () => CustomerNotificationsRepo(sl()),
  );
  sl.registerLazySingleton(() => GetCustomerNotificationsUseCase(sl()));
  sl.registerLazySingleton(
    () => GetCustomerUnseenNotificationsCountUseCase(sl()),
  );
  sl.registerLazySingleton(() => MarkAllCustomerNotificationsSeenUseCase(sl()));
  sl.registerLazySingleton(() => MarkCustomerNotificationClickedUseCase(sl()));
  sl.registerFactory(() => CustomerNotificationsCubit(sl(), sl(), sl(), sl()));
  sl.registerLazySingleton(() => CustomerNotificationRouter());
}
