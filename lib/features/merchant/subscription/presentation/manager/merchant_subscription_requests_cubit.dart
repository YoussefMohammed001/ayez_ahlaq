import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/use_cases/get_merchant_subscription_requests_use_case.dart';
import 'merchant_subscription_requests_state.dart';

class MerchantSubscriptionRequestsCubit extends Cubit<MerchantSubscriptionRequestsState> {
  final GetMerchantSubscriptionRequestsUseCase _getRequests;

  MerchantSubscriptionRequestsCubit(this._getRequests)
    : super(const MerchantSubscriptionRequestsState());

  Future<void> loadRequests() async {
    emit(state.copyWith(status: MerchantSubscriptionRequestsStatus.loading));

    final result = await _getRequests();

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: MerchantSubscriptionRequestsStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (requests) => emit(
        state.copyWith(
          status: MerchantSubscriptionRequestsStatus.success,
          requests: requests,
        ),
      ),
    );
  }
}
