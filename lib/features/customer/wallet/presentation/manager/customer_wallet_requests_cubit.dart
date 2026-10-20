import '../../../../../shared/wallet/presentation/manager/wallet_requests_cubit.dart';

class CustomerWalletRequestsCubit extends WalletRequestsCubit {
  CustomerWalletRequestsCubit(
    super.getWalletRequests,
    super.getWalletRequestDetail,
    super.cancelWalletRequest,
  );
}
