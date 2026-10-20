import '../../../features/barber/wallet/data/apis/barber_wallet_api.dart';
import '../../../features/barber/wallet/data/repos/barber_wallet_repo.dart';
import '../../../features/barber/wallet/domain/repos/i_barber_wallet_repo.dart';
import '../../../features/barber/wallet/domain/use_cases/get_barber_wallet_use_case.dart';
import '../../../features/barber/wallet/presentation/manager/barber_wallet_cubit.dart';
import '../../../features/barber/wallet/data/apis/barber_wallet_requests_api.dart';
import '../../../features/barber/wallet/data/repos/barber_wallet_requests_repo.dart';
import '../../../features/barber/wallet/domain/repos/i_barber_wallet_requests_repo.dart';
import '../../../features/barber/wallet/domain/use_cases/get_wallet_requests_use_case.dart';
import '../../../features/barber/wallet/domain/use_cases/get_wallet_request_detail_use_case.dart';
import '../../../features/barber/wallet/domain/use_cases/create_wallet_request_use_case.dart';
import '../../../features/barber/wallet/domain/use_cases/get_transfer_accounts_use_case.dart';
import '../../../features/barber/wallet/domain/use_cases/get_withdraw_methods_use_case.dart';
import '../../../features/barber/wallet/domain/use_cases/cancel_wallet_request_use_case.dart';
import '../../../features/barber/wallet/domain/use_cases/get_wallet_request_attachment_use_case.dart';
import '../../../features/barber/wallet/presentation/manager/barber_wallet_requests_cubit.dart';
import '../../../features/barber/wallet/presentation/manager/create_wallet_request_cubit.dart';
import '../sl.dart';

void registerBarberWallet() {
  sl.registerLazySingleton(() => BarberWalletApi(sl()));
  sl.registerLazySingleton<IBarberWalletRepo>(() => BarberWalletRepo(sl()));
  sl.registerLazySingleton(() => GetBarberWalletUseCase(sl()));
  sl.registerFactory(() => BarberWalletCubit(sl()));
}

void registerBarberWalletRequests() {
  sl.registerLazySingleton(() => BarberWalletRequestsApi(sl()));
  sl.registerLazySingleton<IBarberWalletRequestsRepo>(
    () => BarberWalletRequestsRepo(sl()),
  );
  sl.registerLazySingleton(() => GetWalletRequestsUseCase(sl()));
  sl.registerLazySingleton(() => GetWalletRequestDetailUseCase(sl()));
  sl.registerLazySingleton(() => CreateWalletRequestUseCase(sl()));
  sl.registerLazySingleton(() => CancelWalletRequestUseCase(sl()));
  sl.registerLazySingleton(() => GetWalletRequestAttachmentUseCase(sl()));
  sl.registerLazySingleton(() => GetTransferAccountsUseCase(sl()));
  sl.registerLazySingleton(() => GetWithdrawMethodsUseCase(sl()));
  sl.registerFactory(() => BarberWalletRequestsCubit(sl(), sl()));
  sl.registerFactory(() => CreateWalletRequestCubit(sl(), sl(), sl()));
}
