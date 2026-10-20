import '../../../features/merchant/sponsorship/data/apis/merchant_sponsorship_api.dart';
import '../../../features/merchant/sponsorship/data/repos/merchant_sponsorship_repo.dart';
import '../../../features/merchant/sponsorship/domain/repos/i_merchant_sponsorship_repo.dart';
import '../../../features/merchant/sponsorship/domain/use_cases/buy_merchant_sponsorship_use_case.dart';
import '../../../features/merchant/sponsorship/domain/use_cases/get_merchant_sponsorship_use_case.dart';
import '../../../features/merchant/sponsorship/presentation/manager/merchant_sponsorship_cubit.dart';
import '../../../features/merchant/subscription/data/apis/merchant_subscription_api.dart';
import '../../../features/merchant/subscription/data/repos/merchant_subscription_repo.dart';
import '../../../features/merchant/subscription/domain/repos/i_merchant_subscription_repo.dart';
import '../../../features/merchant/subscription/domain/use_cases/get_merchant_subscription_use_case.dart';
import '../../../features/merchant/subscription/domain/use_cases/get_merchant_subscription_plans_use_case.dart';
import '../../../features/merchant/subscription/domain/use_cases/subscribe_merchant_use_case.dart';
import '../../../features/merchant/subscription/domain/use_cases/get_merchant_subscription_requests_use_case.dart';
import '../../../features/merchant/subscription/presentation/manager/merchant_subscription_cubit.dart';
import '../../../features/merchant/subscription/presentation/manager/merchant_subscription_requests_cubit.dart';
import '../../../features/merchant/broadcast/data/apis/merchant_broadcast_api.dart';
import '../../../features/merchant/broadcast/data/repos/merchant_broadcast_repo.dart';
import '../../../features/merchant/broadcast/domain/repos/i_merchant_broadcast_repo.dart';
import '../../../features/merchant/broadcast/domain/use_cases/get_merchant_broadcasts_use_case.dart';
import '../../../features/merchant/broadcast/domain/use_cases/send_merchant_broadcast_use_case.dart';
import '../../../features/merchant/broadcast/presentation/manager/merchant_broadcast_cubit.dart';
import '../../../features/merchant/broadcast/presentation/manager/merchant_broadcast_list_cubit.dart';
import '../sl.dart';

void registerMerchantSponsorship() {
  sl.registerLazySingleton(() => MerchantSponsorshipApi(sl()));
  sl.registerLazySingleton<IMerchantSponsorshipRepo>(
    () => MerchantSponsorshipRepo(sl()),
  );
  sl.registerLazySingleton(() => GetMerchantSponsorshipUseCase(sl()));
  sl.registerLazySingleton(() => BuyMerchantSponsorshipUseCase(sl()));
  sl.registerFactory(() => MerchantSponsorshipCubit(sl(), sl()));
}

void registerMerchantSubscription() {
  sl.registerLazySingleton(() => MerchantSubscriptionApi(sl()));
  sl.registerLazySingleton<IMerchantSubscriptionRepo>(
    () => MerchantSubscriptionRepo(sl()),
  );
  sl.registerLazySingleton(() => GetMerchantSubscriptionUseCase(sl()));
  sl.registerLazySingleton(() => GetMerchantSubscriptionPlansUseCase(sl()));
  sl.registerLazySingleton(() => SubscribeMerchantUseCase(sl()));
  sl.registerLazySingleton(() => GetMerchantSubscriptionRequestsUseCase(sl()));
  sl.registerFactory(() => MerchantSubscriptionCubit(sl(), sl(), sl()));
  sl.registerFactory(() => MerchantSubscriptionRequestsCubit(sl()));
}

void registerMerchantBroadcast() {
  sl.registerLazySingleton(() => MerchantBroadcastApi(sl()));
  sl.registerLazySingleton<IMerchantBroadcastRepo>(
    () => MerchantBroadcastRepo(sl()),
  );
  sl.registerLazySingleton(() => SendMerchantBroadcastUseCase(sl()));
  sl.registerLazySingleton(() => GetMerchantBroadcastsUseCase(sl()));
  sl.registerFactory(() => MerchantBroadcastCubit(sl()));
  sl.registerFactory(() => MerchantBroadcastListCubit(sl()));
}
