import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/home_service_request.dart';
import '../../domain/use_cases/get_my_home_service_requests_use_case.dart';
import 'home_service_requests_state.dart';

class HomeServiceRequestsCubit extends Cubit<HomeServiceRequestsState> {
  final GetMyHomeServiceRequestsUseCase _getMyRequests;

  HomeServiceRequestsCubit(this._getMyRequests)
    : super(const HomeServiceRequestsState());

  Future<void> loadRequests() async {
    emit(state.copyWith(status: HomeServiceRequestsStatus.loading));

    final result = await _getMyRequests();

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: HomeServiceRequestsStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (requests) => emit(
        state.copyWith(
          status: HomeServiceRequestsStatus.success,
          requests: requests,
        ),
      ),
    );
  }

  void replace(HomeServiceRequest request) {
    if (!state.requests.any((r) => r.id == request.id)) return;

    emit(
      state.copyWith(
        requests: [
          for (final r in state.requests)
            if (r.id == request.id) request else r,
        ],
      ),
    );
  }
}
