import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/use_cases/get_barber_subscription_requests_use_case.dart';
import 'barber_subscription_requests_state.dart';

class BarberSubscriptionRequestsCubit
    extends Cubit<BarberSubscriptionRequestsState> {
  final GetBarberSubscriptionRequestsUseCase _getRequests;

  BarberSubscriptionRequestsCubit(this._getRequests)
    : super(const BarberSubscriptionRequestsState());

  Future<void> loadRequests() async {
    emit(state.copyWith(status: BarberSubscriptionRequestsStatus.loading));

    final result = await _getRequests();

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: BarberSubscriptionRequestsStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (requests) => emit(
        state.copyWith(
          status: BarberSubscriptionRequestsStatus.success,
          requests: requests,
        ),
      ),
    );
  }
}
