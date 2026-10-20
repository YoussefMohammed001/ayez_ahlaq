import '../../../features/customer/favorites/data/apis/customer_favorites_api.dart';
import '../../../features/customer/favorites/data/repos/customer_favorites_repo.dart';
import '../../../features/customer/favorites/domain/repos/i_customer_favorites_repo.dart';
import '../../../features/customer/favorites/domain/use_cases/add_favorite_use_case.dart';
import '../../../features/customer/favorites/domain/use_cases/add_favorite_via_invite_use_case.dart';
import '../../../features/customer/favorites/domain/use_cases/get_favorites_use_case.dart';
import '../../../features/customer/favorites/domain/use_cases/get_invite_preview_use_case.dart';
import '../../../features/customer/favorites/domain/use_cases/remove_favorite_use_case.dart';
import '../../../features/customer/favorites/presentation/manager/favorites_cubit.dart';
import '../../../features/customer/favorites/presentation/manager/invite_preview_cubit.dart';
import '../../../features/customer/ratings/data/apis/customer_ratings_api.dart';
import '../../../features/customer/ratings/data/repos/customer_ratings_repo.dart';
import '../../../features/customer/ratings/domain/repos/i_customer_ratings_repo.dart';
import '../../../features/customer/ratings/domain/use_cases/get_customer_ratings_use_case.dart';
import '../../../features/customer/ratings/domain/use_cases/get_pending_visit_rating_use_case.dart';
import '../../../features/customer/ratings/domain/use_cases/submit_visit_rating_use_case.dart';
import '../../../features/customer/ratings/presentation/manager/pending_visit_rating_cubit.dart';
import '../../../features/customer/ratings/presentation/manager/customer_ratings_cubit.dart';
import '../sl.dart';

void registerCustomerFavorites() {
  sl.registerLazySingleton(() => CustomerFavoritesApi(sl()));
  sl.registerLazySingleton<ICustomerFavoritesRepo>(
    () => CustomerFavoritesRepo(sl()),
  );
  sl.registerLazySingleton(() => GetFavoritesUseCase(sl()));
  sl.registerLazySingleton(() => AddFavoriteUseCase(sl()));
  sl.registerLazySingleton(() => RemoveFavoriteUseCase(sl()));
  sl.registerLazySingleton(() => AddFavoriteViaInviteUseCase(sl()));
  sl.registerLazySingleton(() => GetInvitePreviewUseCase(sl()));
  sl.registerFactory(() => FavoritesCubit(sl(), sl()));
  sl.registerFactory(() => InvitePreviewCubit(sl(), sl(), sl()));
}

void registerCustomerRatings() {
  sl.registerLazySingleton(() => CustomerRatingsApi(sl()));
  sl.registerLazySingleton<ICustomerRatingsRepo>(
    () => CustomerRatingsRepo(sl()),
  );
  sl.registerLazySingleton(() => GetCustomerRatingsUseCase(sl()));
  sl.registerLazySingleton(() => GetPendingVisitRatingUseCase(sl()));
  sl.registerLazySingleton(() => SubmitVisitRatingUseCase(sl()));
  sl.registerFactory(() => PendingVisitRatingCubit(sl(), sl()));
  sl.registerFactory(() => CustomerRatingsCubit(sl()));
}
