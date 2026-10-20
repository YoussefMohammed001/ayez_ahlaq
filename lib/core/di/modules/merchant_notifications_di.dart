import '../../../features/merchant/notifications/data/apis/merchant_notifications_api.dart';
import '../../../features/merchant/notifications/data/repos/merchant_notifications_repo.dart';
import '../../../features/merchant/notifications/domain/repos/i_merchant_notifications_repo.dart';
import '../../../features/merchant/notifications/domain/use_cases/get_notifications_use_case.dart';
import '../../../features/merchant/notifications/domain/use_cases/get_unseen_notifications_count_use_case.dart';
import '../../../features/merchant/notifications/domain/use_cases/mark_all_notifications_seen_use_case.dart';
import '../../../features/merchant/notifications/domain/use_cases/mark_notification_clicked_use_case.dart';
import '../../../features/merchant/notifications/presentation/manager/merchant_notifications_cubit.dart';
import '../../../features/merchant/device_token/data/apis/merchant_device_token_api.dart';
import '../../../features/merchant/device_token/data/repos/merchant_device_token_repo.dart';
import '../../../features/merchant/device_token/domain/repos/i_merchant_device_token_repo.dart';
import '../../../features/merchant/device_token/domain/use_cases/register_device_token_use_case.dart';
import '../../../features/merchant/device_token/domain/use_cases/unregister_all_device_tokens_use_case.dart';
import '../../../features/merchant/device_token/presentation/services/merchant_device_token_sync_service.dart';
import '../sl.dart';

void registerMerchantNotifications() {
  sl.registerLazySingleton(() => MerchantNotificationsApi(sl()));
  sl.registerLazySingleton<IMerchantNotificationsRepo>(
    () => MerchantNotificationsRepo(sl()),
  );
  sl.registerLazySingleton(() => GetNotificationsUseCase(sl()));
  sl.registerLazySingleton(() => GetUnseenNotificationsCountUseCase(sl()));
  sl.registerLazySingleton(() => MarkAllNotificationsSeenUseCase(sl()));
  sl.registerLazySingleton(() => MarkNotificationClickedUseCase(sl()));
  sl.registerFactory(() => MerchantNotificationsCubit(sl(), sl(), sl(), sl()));
}

void registerMerchantDeviceToken() {
  sl.registerLazySingleton(() => MerchantDeviceTokenApi(sl()));
  sl.registerLazySingleton<IMerchantDeviceTokenRepo>(
    () => MerchantDeviceTokenRepo(sl()),
  );
  sl.registerLazySingleton(() => RegisterDeviceTokenUseCase(sl()));
  sl.registerLazySingleton(() => UnregisterAllDeviceTokensUseCase(sl()));
  sl.registerLazySingleton(
    () => MerchantDeviceTokenSyncService(sl(), sl(), sl()),
  );
}
