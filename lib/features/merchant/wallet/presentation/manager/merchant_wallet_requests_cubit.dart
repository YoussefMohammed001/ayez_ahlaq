import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/wallet_request.dart';
import '../../domain/use_cases/cancel_wallet_request_use_case.dart';
import '../../domain/use_cases/get_wallet_request_detail_use_case.dart';
import '../../domain/use_cases/get_wallet_requests_use_case.dart';
import 'merchant_wallet_requests_state.dart';

class MerchantWalletRequestsCubit extends Cubit<MerchantWalletRequestsState> {
  static const int pageSize = 20;

  final GetWalletRequestsUseCase _getWalletRequests;
  final GetWalletRequestDetailUseCase _getWalletRequestDetail;
  final CancelWalletRequestUseCase _cancelWalletRequest;

  MerchantWalletRequestsCubit(
    this._getWalletRequests,
    this._getWalletRequestDetail,
    this._cancelWalletRequest,
  ) : super(const MerchantWalletRequestsState());

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

  Future<WalletRequest?> refreshRequest(int id) async {
    final result = await _getWalletRequestDetail(id);

    return result.fold((failure) => null, (request) {
      emit(state.copyWith(requests: _replace(request)));
      return request;
    });
  }

  List<WalletRequest> _replace(WalletRequest request) {
    final exists = state.requests.any((r) => r.id == request.id);
    if (!exists) return [...state.requests, request];
    return state.requests.map((r) => r.id == request.id ? request : r).toList();
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
