import '../../../features/customer/wallet/data/apis/customer_wallet_api.dart';
import '../../../features/customer/wallet/data/apis/customer_wallet_requests_api.dart';
import '../../../features/customer/wallet/data/repos/customer_wallet_repo.dart';
import '../../../features/customer/wallet/data/repos/customer_wallet_requests_repo.dart';
import '../../../features/customer/wallet/domain/repos/i_customer_wallet_repo.dart';
import '../../../features/customer/wallet/domain/repos/i_customer_wallet_requests_repo.dart';
import '../../../features/customer/wallet/domain/use_cases/get_customer_wallet_use_case.dart';
import '../../../features/customer/wallet/presentation/manager/customer_wallet_cubit.dart';
import '../../../features/customer/wallet/presentation/manager/customer_wallet_requests_cubit.dart';
import '../../../features/customer/wallet/domain/use_cases/get_wallet_requests_use_case.dart'
    as customer_wallet;
import '../../../features/customer/wallet/domain/use_cases/get_wallet_request_detail_use_case.dart'
    as customer_wallet;
import '../../../features/customer/wallet/domain/use_cases/create_wallet_request_use_case.dart'
    as customer_wallet;
import '../../../features/customer/wallet/domain/use_cases/cancel_wallet_request_use_case.dart'
    as customer_wallet;
import '../../../features/customer/wallet/domain/use_cases/get_wallet_request_attachment_use_case.dart'
    as customer_wallet;
import '../../../features/customer/wallet/domain/use_cases/get_transfer_accounts_use_case.dart'
    as customer_wallet;
import '../../../features/customer/wallet/domain/use_cases/get_withdraw_methods_use_case.dart'
    as customer_wallet;
import '../../../features/customer/wallet/presentation/manager/create_wallet_request_cubit.dart'
    as customer_wallet;
import '../sl.dart';

void registerCustomerWallet() {
  sl.registerLazySingleton(() => CustomerWalletApi(sl()));
  sl.registerLazySingleton<ICustomerWalletRepo>(() => CustomerWalletRepo(sl()));
  sl.registerLazySingleton(() => GetCustomerWalletUseCase(sl()));
  sl.registerFactory(() => CustomerWalletCubit(sl()));
}

void registerCustomerWalletRequests() {
  sl.registerLazySingleton(() => CustomerWalletRequestsApi(sl()));
  sl.registerLazySingleton<ICustomerWalletRequestsRepo>(
    () => CustomerWalletRequestsRepo(sl()),
  );
  sl.registerLazySingleton(
    () => customer_wallet.GetWalletRequestsUseCase(sl()),
  );
  sl.registerLazySingleton(
    () => customer_wallet.GetWalletRequestDetailUseCase(sl()),
  );
  sl.registerLazySingleton(
    () => customer_wallet.CreateWalletRequestUseCase(sl()),
  );
  sl.registerLazySingleton(
    () => customer_wallet.CancelWalletRequestUseCase(sl()),
  );
  sl.registerLazySingleton(
    () => customer_wallet.GetWalletRequestAttachmentUseCase(sl()),
  );
  sl.registerLazySingleton(
    () => customer_wallet.GetTransferAccountsUseCase(sl()),
  );
  sl.registerLazySingleton(
    () => customer_wallet.GetWithdrawMethodsUseCase(sl()),
  );
  sl.registerFactory(() => CustomerWalletRequestsCubit(sl(), sl()));
  sl.registerFactory(
    () => customer_wallet.CreateWalletRequestCubit(sl(), sl(), sl()),
  );
}
