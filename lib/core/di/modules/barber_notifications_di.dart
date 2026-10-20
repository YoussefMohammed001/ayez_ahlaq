import '../../../features/barber/notifications/data/apis/barber_notifications_api.dart';
import '../../../features/barber/notifications/data/repos/barber_notifications_repo.dart';
import '../../../features/barber/notifications/domain/repos/i_barber_notifications_repo.dart';
import '../../../features/barber/notifications/domain/use_cases/get_notifications_use_case.dart'
    as barber;
import '../../../features/barber/notifications/domain/use_cases/get_unseen_notifications_count_use_case.dart'
    as barber;
import '../../../features/barber/notifications/domain/use_cases/mark_all_notifications_seen_use_case.dart'
    as barber;
import '../../../features/barber/notifications/domain/use_cases/mark_notification_clicked_use_case.dart'
    as barber;
import '../../../features/barber/notifications/presentation/manager/barber_notifications_cubit.dart';
import '../../../features/barber/device_token/data/apis/barber_device_token_api.dart';
import '../../../features/barber/device_token/data/repos/barber_device_token_repo.dart';
import '../../../features/barber/device_token/domain/repos/i_barber_device_token_repo.dart';
import '../../../features/barber/device_token/domain/use_cases/register_device_token_use_case.dart'
    as barber;
import '../../../features/barber/device_token/domain/use_cases/unregister_all_device_tokens_use_case.dart'
    as barber;
import '../../../features/barber/device_token/presentation/services/barber_device_token_sync_service.dart';
import '../sl.dart';

void registerBarberNotifications() {
  sl.registerLazySingleton(() => BarberNotificationsApi(sl()));
  sl.registerLazySingleton<IBarberNotificationsRepo>(
    () => BarberNotificationsRepo(sl()),
  );
  sl.registerLazySingleton(() => barber.GetNotificationsUseCase(sl()));
  sl.registerLazySingleton(
    () => barber.GetUnseenNotificationsCountUseCase(sl()),
  );
  sl.registerLazySingleton(() => barber.MarkAllNotificationsSeenUseCase(sl()));
  sl.registerLazySingleton(() => barber.MarkNotificationClickedUseCase(sl()));
  sl.registerFactory(() => BarberNotificationsCubit(sl(), sl(), sl(), sl()));
}

void registerBarberDeviceToken() {
  sl.registerLazySingleton(() => BarberDeviceTokenApi(sl()));
  sl.registerLazySingleton<IBarberDeviceTokenRepo>(
    () => BarberDeviceTokenRepo(sl()),
  );
  sl.registerLazySingleton(() => barber.RegisterDeviceTokenUseCase(sl()));
  sl.registerLazySingleton(() => barber.UnregisterAllDeviceTokensUseCase(sl()));
  sl.registerLazySingleton(
    () => BarberDeviceTokenSyncService(sl(), sl(), sl()),
  );
}
