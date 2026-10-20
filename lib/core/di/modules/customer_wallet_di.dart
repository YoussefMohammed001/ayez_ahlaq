import '../../../features/customer/wallet/presentation/manager/customer_wallet_cubit.dart';
import '../../../features/customer/wallet/presentation/manager/customer_wallet_requests_cubit.dart';
import '../../../shared/wallet/data/wallet_endpoints.dart';
import '../../../shared/wallet/domain/use_cases/cancel_wallet_request_use_case.dart';
import '../../../shared/wallet/domain/use_cases/get_wallet_request_detail_use_case.dart';
import '../../../shared/wallet/domain/use_cases/get_wallet_requests_use_case.dart';
import '../../../shared/wallet/domain/use_cases/get_wallet_use_case.dart';
import '../sl.dart';
import 'shared_wallet_di.dart';

void registerCustomerWallet() {
  registerWalletModule('customer', WalletEndpoints.customer);
  sl.registerFactory(
    () => CustomerWalletCubit(sl<GetWalletUseCase>(instanceName: 'customer')),
  );
}

void registerCustomerWalletRequests() {
  sl.registerFactory(
    () => CustomerWalletRequestsCubit(
      sl<GetWalletRequestsUseCase>(instanceName: 'customer'),
      sl<GetWalletRequestDetailUseCase>(instanceName: 'customer'),
      sl<CancelWalletRequestUseCase>(instanceName: 'customer'),
    ),
  );
}
