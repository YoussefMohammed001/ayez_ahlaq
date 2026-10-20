import '../../../features/barber/sponsorship/data/apis/barber_sponsorship_api.dart';
import '../../../features/barber/sponsorship/data/repos/barber_sponsorship_repo.dart';
import '../../../features/barber/sponsorship/domain/repos/i_barber_sponsorship_repo.dart';
import '../../../features/barber/sponsorship/domain/use_cases/buy_barber_sponsorship_use_case.dart';
import '../../../features/barber/sponsorship/domain/use_cases/get_barber_sponsorship_use_case.dart';
import '../../../features/barber/sponsorship/presentation/manager/barber_sponsorship_cubit.dart';
import '../../../features/barber/ratings/data/apis/barber_ratings_api.dart';
import '../../../features/barber/ratings/data/repos/barber_ratings_repo.dart';
import '../../../features/barber/ratings/domain/repos/i_barber_ratings_repo.dart';
import '../../../features/barber/ratings/domain/use_cases/get_pending_merchant_rating_use_case.dart';
import '../../../features/barber/ratings/domain/use_cases/submit_merchant_rating_use_case.dart';
import '../../../features/barber/ratings/presentation/manager/pending_merchant_rating_cubit.dart';
import '../../../features/barber/reviews/data/apis/barber_reviews_api.dart';
import '../../../features/barber/reviews/data/repos/barber_reviews_repo.dart';
import '../../../features/barber/reviews/domain/repos/i_barber_reviews_repo.dart';
import '../../../features/barber/reviews/domain/use_cases/get_barber_reviews_use_case.dart';
import '../../../features/barber/reviews/presentation/manager/barber_reviews_cubit.dart';
import '../../../features/barber/invite/data/apis/barber_invite_api.dart';
import '../../../features/barber/invite/data/repos/barber_invite_repo.dart';
import '../../../features/barber/invite/domain/repos/i_barber_invite_repo.dart';
import '../../../features/barber/invite/domain/use_cases/get_barber_invite_use_case.dart';
import '../../../features/barber/invite/domain/use_cases/regenerate_barber_invite_use_case.dart';
import '../../../features/barber/invite/presentation/manager/barber_invite_cubit.dart';
import '../../../features/barber/subscription/data/apis/barber_subscription_api.dart';
import '../../../features/barber/subscription/data/repos/barber_subscription_repo.dart';
import '../../../features/barber/subscription/domain/repos/i_barber_subscription_repo.dart';
import '../../../features/barber/subscription/domain/use_cases/get_barber_subscription_use_case.dart';
import '../../../features/barber/subscription/domain/use_cases/get_barber_subscription_plans_use_case.dart';
import '../../../features/barber/subscription/domain/use_cases/subscribe_barber_use_case.dart';
import '../../../features/barber/subscription/domain/use_cases/get_barber_subscription_requests_use_case.dart';
import '../../../features/barber/subscription/presentation/manager/barber_subscription_cubit.dart';
import '../../../features/barber/subscription/presentation/manager/barber_subscription_requests_cubit.dart';
import '../../../features/barber/broadcast/data/apis/barber_broadcast_api.dart';
import '../../../features/barber/broadcast/data/repos/barber_broadcast_repo.dart';
import '../../../features/barber/broadcast/domain/repos/i_barber_broadcast_repo.dart';
import '../../../features/barber/broadcast/domain/use_cases/get_broadcasts_use_case.dart';
import '../../../features/barber/broadcast/domain/use_cases/send_barber_broadcast_use_case.dart';
import '../../../features/barber/broadcast/presentation/manager/barber_broadcast_cubit.dart';
import '../../../features/barber/broadcast/presentation/manager/broadcast_list_cubit.dart';
import '../sl.dart';

void registerBarberSponsorship() {
  sl.registerLazySingleton(() => BarberSponsorshipApi(sl()));
  sl.registerLazySingleton<IBarberSponsorshipRepo>(
    () => BarberSponsorshipRepo(sl()),
  );
  sl.registerLazySingleton(() => GetBarberSponsorshipUseCase(sl()));
  sl.registerLazySingleton(() => BuyBarberSponsorshipUseCase(sl()));
  sl.registerFactory(() => BarberSponsorshipCubit(sl(), sl()));
}

void registerBarberRatings() {
  sl.registerLazySingleton(() => BarberRatingsApi(sl()));
  sl.registerLazySingleton<IBarberRatingsRepo>(() => BarberRatingsRepo(sl()));
  sl.registerLazySingleton(() => GetPendingMerchantRatingUseCase(sl()));
  sl.registerLazySingleton(() => SubmitMerchantRatingUseCase(sl()));
  sl.registerFactory(() => PendingMerchantRatingCubit(sl(), sl()));
}

void registerBarberReviews() {
  sl.registerLazySingleton(() => BarberReviewsApi(sl()));
  sl.registerLazySingleton<IBarberReviewsRepo>(() => BarberReviewsRepo(sl()));
  sl.registerLazySingleton(() => GetBarberReviewsUseCase(sl()));
  sl.registerFactory(() => BarberReviewsCubit(sl()));
}

void registerBarberInvite() {
  sl.registerLazySingleton(() => BarberInviteApi(sl()));
  sl.registerLazySingleton<IBarberInviteRepo>(() => BarberInviteRepo(sl()));
  sl.registerLazySingleton(() => GetBarberInviteUseCase(sl()));
  sl.registerLazySingleton(() => RegenerateBarberInviteUseCase(sl()));
  sl.registerFactory(() => BarberInviteCubit(sl(), sl()));
}

void registerBarberSubscription() {
  sl.registerLazySingleton(() => BarberSubscriptionApi(sl()));
  sl.registerLazySingleton<IBarberSubscriptionRepo>(
    () => BarberSubscriptionRepo(sl()),
  );
  sl.registerLazySingleton(() => GetBarberSubscriptionUseCase(sl()));
  sl.registerLazySingleton(() => GetBarberSubscriptionPlansUseCase(sl()));
  sl.registerLazySingleton(() => SubscribeBarberUseCase(sl()));
  sl.registerLazySingleton(() => GetBarberSubscriptionRequestsUseCase(sl()));
  sl.registerFactory(() => BarberSubscriptionCubit(sl(), sl(), sl()));
  sl.registerFactory(() => BarberSubscriptionRequestsCubit(sl()));
}

void registerBarberBroadcast() {
  sl.registerLazySingleton(() => BarberBroadcastApi(sl()));
  sl.registerLazySingleton<IBarberBroadcastRepo>(
    () => BarberBroadcastRepo(sl()),
  );
  sl.registerLazySingleton(() => SendBarberBroadcastUseCase(sl()));
  sl.registerLazySingleton(() => GetBroadcastsUseCase(sl()));
  sl.registerFactory(() => BarberBroadcastCubit(sl()));
  sl.registerFactory(() => BroadcastListCubit(sl()));
}
