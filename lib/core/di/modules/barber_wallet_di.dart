import '../../../features/barber/wallet/presentation/manager/barber_wallet_cubit.dart';
import '../../../features/barber/wallet/presentation/manager/barber_wallet_requests_cubit.dart';
import '../../../shared/wallet/data/wallet_endpoints.dart';
import '../../../shared/wallet/domain/use_cases/cancel_wallet_request_use_case.dart';
import '../../../shared/wallet/domain/use_cases/get_wallet_request_attachment_use_case.dart';
import '../../../shared/wallet/domain/use_cases/get_wallet_request_detail_use_case.dart';
import '../../../shared/wallet/domain/use_cases/get_wallet_requests_use_case.dart';
import '../../../shared/wallet/domain/use_cases/get_wallet_use_case.dart';
import '../sl.dart';
import 'shared_wallet_di.dart';

void registerBarberWallet() {
  registerWalletModule('barber', WalletEndpoints.barber);
  sl.registerFactory(
    () => BarberWalletCubit(sl<GetWalletUseCase>(instanceName: 'barber')),
  );
}

void registerBarberWalletRequests() {
  sl.registerFactory(
    () => BarberWalletRequestsCubit(
      sl<GetWalletRequestsUseCase>(instanceName: 'barber'),
      sl<GetWalletRequestDetailUseCase>(instanceName: 'barber'),
      sl<CancelWalletRequestUseCase>(instanceName: 'barber'),
      sl<GetWalletRequestAttachmentUseCase>(instanceName: 'barber'),
    ),
  );
}
