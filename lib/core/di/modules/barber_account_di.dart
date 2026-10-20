import '../../../features/barber/profile/domain/use_cases/delete_barber_account_use_case.dart';
import '../../../features/barber/profile/data/apis/barber_profile_api.dart';
import '../../../features/barber/profile/data/repos/barber_profile_repo.dart';
import '../../../features/barber/profile/domain/repos/i_barber_profile_repo.dart';
import '../../../features/barber/profile/data/local/barber_profile_image_cache.dart';
import '../../../features/barber/profile/domain/use_cases/delete_barber_profile_image_use_case.dart';
import '../../../features/barber/profile/domain/use_cases/get_barber_profile_image_use_case.dart';
import '../../../features/barber/profile/domain/use_cases/get_barber_profile_use_case.dart';
import '../../../features/barber/profile/domain/use_cases/get_cached_barber_profile_image_use_case.dart';
import '../../../features/barber/profile/domain/use_cases/update_barber_location_use_case.dart';
import '../../../features/barber/profile/domain/use_cases/update_serves_clients_use_case.dart';
import '../../../features/barber/profile/domain/use_cases/upload_barber_profile_image_use_case.dart';
import '../../../features/barber/payment_methods/data/apis/barber_payment_methods_api.dart';
import '../../../features/barber/payment_methods/data/repos/barber_payment_methods_repo.dart';
import '../../../features/barber/payment_methods/domain/repos/i_barber_payment_methods_repo.dart';
import '../../../features/barber/payment_methods/domain/use_cases/get_barber_payment_methods_use_case.dart';
import '../../../features/barber/payment_methods/presentation/manager/barber_payment_methods_cubit.dart';
import '../../../features/barber/profile/domain/use_cases/change_barber_password_use_case.dart';
import '../../../features/barber/profile/presentation/manager/barber_profile_cubit.dart';
import '../../../features/barber/documents/data/apis/barber_documents_api.dart';
import '../../../features/barber/documents/data/repos/barber_documents_repo.dart';
import '../../../features/barber/documents/domain/repos/i_barber_documents_repo.dart';
import '../../../features/barber/documents/domain/use_cases/delete_document_file_use_case.dart'
    as barber;
import '../../../features/barber/documents/domain/use_cases/download_document_file_use_case.dart'
    as barber;
import '../../../features/barber/documents/domain/use_cases/get_documents_use_case.dart'
    as barber;
import '../../../features/barber/documents/domain/use_cases/upload_document_file_use_case.dart'
    as barber;
import '../../../features/barber/documents/presentation/manager/barber_documents_cubit.dart';
import '../sl.dart';

void registerBarberProfile() {
  sl.registerLazySingleton(() => BarberProfileApi(sl()));
  sl.registerLazySingleton(() => BarberProfileImageCache());
  sl.registerLazySingleton<IBarberProfileRepo>(
    () => BarberProfileRepo(sl(), sl(), sl()),
  );
  sl.registerLazySingleton(() => GetBarberProfileUseCase(sl()));
  sl.registerLazySingleton(() => UpdateBarberLocationUseCase(sl()));
  sl.registerLazySingleton(() => UpdateServesClientsUseCase(sl()));
  sl.registerLazySingleton(() => ChangeBarberPasswordUseCase(sl()));
  sl.registerLazySingleton(() => DeleteBarberAccountUseCase(sl()));
  sl.registerLazySingleton(() => UploadBarberProfileImageUseCase(sl()));
  sl.registerLazySingleton(() => GetBarberProfileImageUseCase(sl()));
  sl.registerLazySingleton(() => GetCachedBarberProfileImageUseCase(sl()));
  sl.registerLazySingleton(() => DeleteBarberProfileImageUseCase(sl()));
  sl.registerFactory(
    () => BarberProfileCubit(
      sl(),
      sl(),
      sl(),
      sl(),
      sl(),
      sl(),
      sl(),
      sl(),
      sl(),
    ),
  );
}

void registerBarberPaymentMethods() {
  sl.registerLazySingleton(() => BarberPaymentMethodsApi(sl()));
  sl.registerLazySingleton<IBarberPaymentMethodsRepo>(
    () => BarberPaymentMethodsRepo(sl()),
  );
  sl.registerLazySingleton(() => GetBarberPaymentMethodsUseCase(sl()));
  sl.registerFactory(() => BarberPaymentMethodsCubit(sl()));
}

void registerBarberDocuments() {
  sl.registerLazySingleton(() => BarberDocumentsApi(sl()));
  sl.registerLazySingleton<IBarberDocumentsRepo>(
    () => BarberDocumentsRepo(sl()),
  );
  sl.registerLazySingleton(() => barber.GetDocumentsUseCase(sl()));
  sl.registerLazySingleton(() => barber.UploadDocumentFileUseCase(sl()));
  sl.registerLazySingleton(() => barber.DeleteDocumentFileUseCase(sl()));
  sl.registerLazySingleton(() => barber.DownloadDocumentFileUseCase(sl()));
  sl.registerFactory(() => BarberDocumentsCubit(sl(), sl(), sl(), sl()));
}
