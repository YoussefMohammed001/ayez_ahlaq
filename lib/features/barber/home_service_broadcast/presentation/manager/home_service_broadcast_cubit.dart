import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/home_service_broadcast.dart';
import '../../domain/use_cases/accept_home_service_broadcast_use_case.dart';
import '../../domain/use_cases/get_home_service_broadcast_for_request_use_case.dart';
import '../../domain/use_cases/get_home_service_broadcasts_use_case.dart';
import '../../domain/use_cases/reject_home_service_broadcast_use_case.dart';
import 'home_service_broadcast_state.dart';

class HomeServiceBroadcastCubit extends Cubit<HomeServiceBroadcastState> {
  final GetHomeServiceBroadcastsUseCase _getBroadcasts;
  final GetHomeServiceBroadcastForRequestUseCase _getBroadcastForRequest;
  final AcceptHomeServiceBroadcastUseCase _acceptBroadcast;
  final RejectHomeServiceBroadcastUseCase _rejectBroadcast;

  HomeServiceBroadcastCubit(
    this._getBroadcasts,
    this._getBroadcastForRequest,
    this._acceptBroadcast,
    this._rejectBroadcast,
  ) : super(const HomeServiceBroadcastState());

  Future<void> loadBroadcasts() async {
    emit(state.copyWith(status: HomeServiceBroadcastStatus.loading));

    final result = await _getBroadcasts();

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: HomeServiceBroadcastStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (broadcasts) => emit(
        state.copyWith(
          status: HomeServiceBroadcastStatus.success,
          broadcasts: broadcasts,
        ),
      ),
    );
  }

  Future<HomeServiceBroadcast?> resolveForRequest(int requestId) async {
    emit(state.copyWith(status: HomeServiceBroadcastStatus.loading));

    final result = await _getBroadcastForRequest(requestId);

    return result.fold(
      (failure) {
        emit(
          state.copyWith(
            status: HomeServiceBroadcastStatus.failure,
            errorMessage: failure.message,
          ),
        );
        return null;
      },
      (broadcast) {
        final exists = state.broadcasts.any(
          (b) => b.candidateId == broadcast.candidateId,
        );
        emit(
          state.copyWith(
            status: HomeServiceBroadcastStatus.success,
            broadcasts: exists
                ? state.broadcasts
                : [...state.broadcasts, broadcast],
          ),
        );
        return broadcast;
      },
    );
  }

  Future<bool> accept(int candidateId) =>
      _mutate(candidateId, () => _acceptBroadcast(candidateId));

  Future<bool> reject(int candidateId) =>
      _mutate(candidateId, () => _rejectBroadcast(candidateId));

  Future<bool> _mutate(
    int candidateId,
    Future<dynamic> Function() action,
  ) async {
    emit(state.copyWith(updatingBroadcastId: candidateId));

    final result = await action();

    return result.fold(
      (failure) {
        emit(
          state.copyWith(
            clearUpdatingBroadcastId: true,
            errorMessage: failure.message,
          ),
        );
        return false;
      },
      (_) {
        emit(
          state.copyWith(
            clearUpdatingBroadcastId: true,
            broadcasts: state.broadcasts
                .where((b) => b.candidateId != candidateId)
                .toList(),
          ),
        );
        return true;
      },
    );
  }
}
