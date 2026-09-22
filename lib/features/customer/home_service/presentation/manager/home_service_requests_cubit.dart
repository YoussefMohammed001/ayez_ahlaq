import 'package:flutter_bloc/flutter_bloc.dart';
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
}
