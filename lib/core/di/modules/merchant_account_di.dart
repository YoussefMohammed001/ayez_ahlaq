import '../../../features/merchant/profile/domain/use_cases/delete_merchant_account_use_case.dart';
import '../../../features/merchant/documents/data/apis/merchant_documents_api.dart';
import '../../../features/merchant/documents/data/repos/merchant_documents_repo.dart';
import '../../../features/merchant/documents/domain/repos/i_merchant_documents_repo.dart';
import '../../../features/merchant/documents/domain/use_cases/delete_document_file_use_case.dart';
import '../../../features/merchant/documents/domain/use_cases/download_document_file_use_case.dart';
import '../../../features/merchant/documents/domain/use_cases/get_documents_use_case.dart';
import '../../../features/merchant/documents/domain/use_cases/upload_document_file_use_case.dart';
import '../../../features/merchant/documents/presentation/manager/merchant_documents_cubit.dart';
import '../../../features/merchant/profile/data/apis/merchant_profile_api.dart';
import '../../../features/merchant/profile/data/repos/merchant_profile_repo.dart';
import '../../../features/merchant/profile/domain/repos/i_merchant_profile_repo.dart';
import '../../../features/merchant/profile/domain/use_cases/change_password_use_case.dart';
import '../../../features/merchant/profile/domain/use_cases/get_merchant_profile_use_case.dart';
import '../../../features/merchant/profile/domain/use_cases/update_merchant_location_use_case.dart';
import '../../../features/merchant/profile/domain/use_cases/update_merchant_profile_use_case.dart';
import '../../../features/merchant/profile/domain/use_cases/add_phone_use_case.dart';
import '../../../features/merchant/profile/domain/use_cases/delete_phone_use_case.dart';
import '../../../features/merchant/profile/domain/use_cases/get_phones_use_case.dart';
import '../../../features/merchant/profile/presentation/manager/merchant_phones_cubit.dart';
import '../../../features/merchant/profile/presentation/manager/merchant_profile_cubit.dart';
import '../sl.dart';

void registerMerchantDocuments() {
  sl.registerLazySingleton(() => MerchantDocumentsApi(sl()));
  sl.registerLazySingleton<IMerchantDocumentsRepo>(
    () => MerchantDocumentsRepo(sl()),
  );
  sl.registerLazySingleton(() => GetDocumentsUseCase(sl()));
  sl.registerLazySingleton(() => UploadDocumentFileUseCase(sl()));
  sl.registerLazySingleton(() => DeleteDocumentFileUseCase(sl()));
  sl.registerLazySingleton(() => DownloadDocumentFileUseCase(sl()));
  sl.registerFactory(() => MerchantDocumentsCubit(sl(), sl(), sl(), sl()));
}

void registerMerchantProfile() {
  sl.registerLazySingleton(() => MerchantProfileApi(sl()));
  sl.registerLazySingleton<IMerchantProfileRepo>(
    () => MerchantProfileRepo(sl(), sl()),
  );
  sl.registerLazySingleton(() => GetMerchantProfileUseCase(sl()));
  sl.registerLazySingleton(() => UpdateMerchantProfileUseCase(sl()));
  sl.registerLazySingleton(() => UpdateMerchantLocationUseCase(sl()));
  sl.registerLazySingleton(() => ChangePasswordUseCase(sl()));
  sl.registerLazySingleton(() => DeleteMerchantAccountUseCase(sl()));
  sl.registerFactory(() => MerchantProfileCubit(sl(), sl(), sl(), sl(), sl()));
  sl.registerLazySingleton(() => GetPhonesUseCase(sl()));
  sl.registerLazySingleton(() => AddPhoneUseCase(sl()));
  sl.registerLazySingleton(() => DeletePhoneUseCase(sl()));
  sl.registerFactory(() => MerchantPhonesCubit(sl(), sl(), sl()));
}
