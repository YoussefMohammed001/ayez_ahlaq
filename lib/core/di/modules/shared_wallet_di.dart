import '../../../shared/wallet/data/apis/wallet_api.dart';
import '../../../shared/wallet/data/apis/wallet_requests_api.dart';
import '../../../shared/wallet/data/repos/wallet_repo.dart';
import '../../../shared/wallet/data/repos/wallet_requests_repo.dart';
import '../../../shared/wallet/data/wallet_endpoints.dart';
import '../../../shared/wallet/domain/repos/i_wallet_repo.dart';
import '../../../shared/wallet/domain/repos/i_wallet_requests_repo.dart';
import '../../../shared/wallet/domain/use_cases/cancel_wallet_request_use_case.dart';
import '../../../shared/wallet/domain/use_cases/create_wallet_request_use_case.dart';
import '../../../shared/wallet/domain/use_cases/get_transfer_accounts_use_case.dart';
import '../../../shared/wallet/domain/use_cases/get_wallet_request_attachment_use_case.dart';
import '../../../shared/wallet/domain/use_cases/get_wallet_request_detail_use_case.dart';
import '../../../shared/wallet/domain/use_cases/get_wallet_requests_use_case.dart';
import '../../../shared/wallet/domain/use_cases/get_wallet_use_case.dart';
import '../../../shared/wallet/domain/use_cases/get_withdraw_methods_use_case.dart';
import '../../../shared/wallet/presentation/manager/create_wallet_request_cubit.dart';
import '../sl.dart';

void registerWalletModule(String role, WalletEndpoints endpoints) {
  T find<T extends Object>() => sl<T>(instanceName: role);

  sl.registerLazySingleton(
    () => WalletApi(sl(), endpoints),
    instanceName: role,
  );
  sl.registerLazySingleton(
    () => WalletRequestsApi(sl(), endpoints),
    instanceName: role,
  );
  sl.registerLazySingleton<IWalletRepo>(
    () => WalletRepo(find<WalletApi>()),
    instanceName: role,
  );
  sl.registerLazySingleton<IWalletRequestsRepo>(
    () => WalletRequestsRepo(find<WalletRequestsApi>()),
    instanceName: role,
  );
  sl.registerLazySingleton(
    () => GetWalletUseCase(find<IWalletRepo>()),
    instanceName: role,
  );
  sl.registerLazySingleton(
    () => GetWalletRequestsUseCase(find<IWalletRequestsRepo>()),
    instanceName: role,
  );
  sl.registerLazySingleton(
    () => GetWalletRequestDetailUseCase(find<IWalletRequestsRepo>()),
    instanceName: role,
  );
  sl.registerLazySingleton(
    () => CreateWalletRequestUseCase(find<IWalletRequestsRepo>()),
    instanceName: role,
  );
  sl.registerLazySingleton(
    () => CancelWalletRequestUseCase(find<IWalletRequestsRepo>()),
    instanceName: role,
  );
  sl.registerLazySingleton(
    () => GetWalletRequestAttachmentUseCase(find<IWalletRequestsRepo>()),
    instanceName: role,
  );
  sl.registerLazySingleton(
    () => GetTransferAccountsUseCase(find<IWalletRequestsRepo>()),
    instanceName: role,
  );
  sl.registerLazySingleton(
    () => GetWithdrawMethodsUseCase(find<IWalletRequestsRepo>()),
    instanceName: role,
  );
  sl.registerFactory(
    () => CreateWalletRequestCubit(
      find<CreateWalletRequestUseCase>(),
      find<GetTransferAccountsUseCase>(),
      find<GetWithdrawMethodsUseCase>(),
    ),
    instanceName: role,
  );
}
