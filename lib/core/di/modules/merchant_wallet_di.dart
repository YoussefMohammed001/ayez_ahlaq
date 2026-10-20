import '../../../features/merchant/wallet/data/apis/merchant_wallet_api.dart';
import '../../../features/merchant/wallet/data/apis/merchant_wallet_requests_api.dart';
import '../../../features/merchant/wallet/data/repos/merchant_wallet_repo.dart';
import '../../../features/merchant/wallet/data/repos/merchant_wallet_requests_repo.dart';
import '../../../features/merchant/wallet/domain/repos/i_merchant_wallet_repo.dart';
import '../../../features/merchant/wallet/domain/repos/i_merchant_wallet_requests_repo.dart';
import '../../../features/merchant/wallet/domain/use_cases/get_merchant_wallet_use_case.dart';
import '../../../features/merchant/wallet/presentation/manager/merchant_wallet_cubit.dart';
import '../../../features/merchant/wallet/presentation/manager/merchant_wallet_requests_cubit.dart';
import '../../../features/merchant/wallet/domain/use_cases/get_wallet_requests_use_case.dart'
    as merchant_wallet;
import '../../../features/merchant/wallet/domain/use_cases/get_wallet_request_detail_use_case.dart'
    as merchant_wallet;
import '../../../features/merchant/wallet/domain/use_cases/create_wallet_request_use_case.dart'
    as merchant_wallet;
import '../../../features/merchant/wallet/domain/use_cases/cancel_wallet_request_use_case.dart'
    as merchant_wallet;
import '../../../features/merchant/wallet/domain/use_cases/get_wallet_request_attachment_use_case.dart'
    as merchant_wallet;
import '../../../features/merchant/wallet/domain/use_cases/get_transfer_accounts_use_case.dart'
    as merchant_wallet;
import '../../../features/merchant/wallet/domain/use_cases/get_withdraw_methods_use_case.dart'
    as merchant_wallet;
import '../../../features/merchant/wallet/presentation/manager/create_wallet_request_cubit.dart'
    as merchant_wallet;
import '../sl.dart';

void registerMerchantWallet() {
  sl.registerLazySingleton(() => MerchantWalletApi(sl()));
  sl.registerLazySingleton<IMerchantWalletRepo>(() => MerchantWalletRepo(sl()));
  sl.registerLazySingleton(() => GetMerchantWalletUseCase(sl()));
  sl.registerFactory(() => MerchantWalletCubit(sl()));
}

void registerMerchantWalletRequests() {
  sl.registerLazySingleton(() => MerchantWalletRequestsApi(sl()));
  sl.registerLazySingleton<IMerchantWalletRequestsRepo>(
    () => MerchantWalletRequestsRepo(sl()),
  );
  sl.registerLazySingleton(
    () => merchant_wallet.GetWalletRequestsUseCase(sl()),
  );
  sl.registerLazySingleton(
    () => merchant_wallet.GetWalletRequestDetailUseCase(sl()),
  );
  sl.registerLazySingleton(
    () => merchant_wallet.CreateWalletRequestUseCase(sl()),
  );
  sl.registerLazySingleton(
    () => merchant_wallet.CancelWalletRequestUseCase(sl()),
  );
  sl.registerLazySingleton(
    () => merchant_wallet.GetWalletRequestAttachmentUseCase(sl()),
  );
  sl.registerLazySingleton(
    () => merchant_wallet.GetTransferAccountsUseCase(sl()),
  );
  sl.registerLazySingleton(
    () => merchant_wallet.GetWithdrawMethodsUseCase(sl()),
  );
  sl.registerFactory(() => MerchantWalletRequestsCubit(sl(), sl(), sl()));
  sl.registerFactory(
    () => merchant_wallet.CreateWalletRequestCubit(sl(), sl(), sl()),
  );
}
