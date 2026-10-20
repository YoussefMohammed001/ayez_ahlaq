import '../../../../../shared/wallet/presentation/manager/wallet_requests_cubit.dart';

class MerchantWalletRequestsCubit extends WalletRequestsCubit {
  MerchantWalletRequestsCubit(
    super.getWalletRequests,
    super.getWalletRequestDetail,
    super.cancelWalletRequest,
    super.getAttachment,
  );
}
