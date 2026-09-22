import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/home_service_request.dart';
import '../../domain/entities/home_service_request_adjustment.dart';
import '../../domain/entities/home_service_request_status.dart';
import '../../domain/use_cases/accept_home_service_request_use_case.dart';
import '../../domain/use_cases/get_home_service_request_use_case.dart';
import '../../domain/use_cases/get_home_service_requests_use_case.dart';
import '../../domain/use_cases/reject_home_service_request_use_case.dart';
import '../../domain/use_cases/update_home_service_request_price_use_case.dart';
import '../../domain/use_cases/update_home_service_request_status_use_case.dart';
import 'home_service_requests_state.dart';

class HomeServiceRequestsCubit extends Cubit<HomeServiceRequestsState> {
  final GetHomeServiceRequestsUseCase _getRequests;
  final GetHomeServiceRequestUseCase _getRequest;
  final UpdateHomeServiceRequestPriceUseCase _updatePrice;
  final AcceptHomeServiceRequestUseCase _acceptRequest;
  final RejectHomeServiceRequestUseCase _rejectRequest;
  final UpdateHomeServiceRequestStatusUseCase _updateStatus;

  HomeServiceRequestsCubit(
    this._getRequests,
    this._getRequest,
    this._updatePrice,
    this._acceptRequest,
    this._rejectRequest,
    this._updateStatus,
  ) : super(const HomeServiceRequestsState());

  Future<HomeServiceRequest?> refreshRequest(int id) async {
    final result = await _getRequest(id);

    return result.fold((failure) => null, (request) {
      final exists = state.requests.any((r) => r.id == id);
      emit(
        state.copyWith(
          requests: exists
              ? _replace(state.requests, request)
              : [...state.requests, request],
        ),
      );
      return request;
    });
  }

  Future<void> loadPending() async {
    emit(state.copyWith(status: HomeServiceRequestsStatus.loading));

    final result = await _getRequests(status: HomeServiceRequestStatus.pending);

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

  Future<void> updatePrice(
    int id,
    List<HomeServiceRequestAdjustment> adjustments,
  ) => _mutate(id, () => _updatePrice(id, adjustments));

  Future<void> accept(int id) => _mutate(id, () => _acceptRequest(id));

  Future<void> reject(int id, String reason) =>
      _mutate(id, () => _rejectRequest(id, reason));

  Future<void> advanceStatus(int id, HomeServiceRequestStatus status) =>
      _mutate(id, () => _updateStatus(id, status));

  Future<void> _mutate(int id, Future<dynamic> Function() action) async {
    emit(state.copyWith(updatingRequestId: id));

    final result = await action();

    result.fold(
      (failure) => emit(
        state.copyWith(
          clearUpdatingRequestId: true,
          errorMessage: failure.message,
        ),
      ),
      (request) => emit(
        state.copyWith(
          clearUpdatingRequestId: true,
          requests: _replace(state.requests, request),
        ),
      ),
    );
  }

  List<HomeServiceRequest> _replace(
    List<HomeServiceRequest> requests,
    HomeServiceRequest updated,
  ) {
    if (!requests.any((request) => request.id == updated.id)) {
      return requests;
    }
    return [
      for (final request in requests)
        if (request.id == updated.id) updated else request,
    ];
  }
}
