import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/use_cases/cancel_wallet_request_use_case.dart';
import '../../domain/use_cases/get_wallet_requests_use_case.dart';
import 'customer_wallet_requests_state.dart';

class CustomerWalletRequestsCubit extends Cubit<CustomerWalletRequestsState> {
  static const int pageSize = 20;

  final GetWalletRequestsUseCase _getWalletRequests;
  final CancelWalletRequestUseCase _cancelWalletRequest;

  CustomerWalletRequestsCubit(this._getWalletRequests, this._cancelWalletRequest)
    : super(const CustomerWalletRequestsState());

  Future<void> loadRequests() async {
    emit(state.copyWith(status: WalletRequestsListStatus.loading));

    final result = await _getWalletRequests(page: 0, size: pageSize);

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: WalletRequestsListStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (page) => emit(
        state.copyWith(
          status: WalletRequestsListStatus.success,
          requests: page.content,
          page: page.page,
          hasMore: page.hasMore,
        ),
      ),
    );
  }

  Future<void> loadMore() async {
    if (!state.hasMore || state.status == WalletRequestsListStatus.loadingMore) {
      return;
    }

    emit(state.copyWith(status: WalletRequestsListStatus.loadingMore));

    final result = await _getWalletRequests(page: state.page + 1, size: pageSize);

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: WalletRequestsListStatus.success,
          errorMessage: failure.message,
        ),
      ),
      (page) => emit(
        state.copyWith(
          status: WalletRequestsListStatus.success,
          requests: [...state.requests, ...page.content],
          page: page.page,
          hasMore: page.hasMore,
        ),
      ),
    );
  }

  Future<bool> cancelRequest(int id) async {
    emit(state.copyWith(cancellingIds: {...state.cancellingIds, id}));

    final result = await _cancelWalletRequest(id);

    return result.fold(
      (failure) {
        emit(
          state.copyWith(
            cancellingIds: _without(id),
            errorMessage: failure.message,
          ),
        );
        return false;
      },
      (updated) {
        emit(
          state.copyWith(
            cancellingIds: _without(id),
            requests: state.requests
                .map((r) => r.id == updated.id ? updated : r)
                .toList(),
          ),
        );
        return true;
      },
    );
  }

  Set<int> _without(int id) =>
      state.cancellingIds.where((element) => element != id).toSet();
}
