import '../../../features/merchant/wallet/presentation/manager/merchant_wallet_cubit.dart';
import '../../../features/merchant/wallet/presentation/manager/merchant_wallet_requests_cubit.dart';
import '../../../shared/wallet/data/wallet_endpoints.dart';
import '../../../shared/wallet/domain/use_cases/cancel_wallet_request_use_case.dart';
import '../../../shared/wallet/domain/use_cases/get_wallet_request_attachment_use_case.dart';
import '../../../shared/wallet/domain/use_cases/get_wallet_request_detail_use_case.dart';
import '../../../shared/wallet/domain/use_cases/get_wallet_requests_use_case.dart';
import '../../../shared/wallet/domain/use_cases/get_wallet_use_case.dart';
import '../sl.dart';
import 'shared_wallet_di.dart';

void registerMerchantWallet() {
  registerWalletModule('merchant', WalletEndpoints.merchant);
  sl.registerFactory(
    () => MerchantWalletCubit(sl<GetWalletUseCase>(instanceName: 'merchant')),
  );
}

void registerMerchantWalletRequests() {
  sl.registerFactory(
    () => MerchantWalletRequestsCubit(
      sl<GetWalletRequestsUseCase>(instanceName: 'merchant'),
      sl<GetWalletRequestDetailUseCase>(instanceName: 'merchant'),
      sl<CancelWalletRequestUseCase>(instanceName: 'merchant'),
      sl<GetWalletRequestAttachmentUseCase>(instanceName: 'merchant'),
    ),
  );
}
