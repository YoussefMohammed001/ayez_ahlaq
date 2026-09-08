import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/use_cases/get_merchant_broadcasts_use_case.dart';
import 'merchant_broadcast_list_state.dart';

class MerchantBroadcastListCubit extends Cubit<MerchantBroadcastListState> {
  static const int pageSize = 20;

  final GetMerchantBroadcastsUseCase _getBroadcasts;

  MerchantBroadcastListCubit(this._getBroadcasts)
    : super(const MerchantBroadcastListState());

  Future<void> loadBroadcasts() async {
    emit(state.copyWith(status: MerchantBroadcastListStatus.loading));

    final result = await _getBroadcasts(page: 0, size: pageSize);

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: MerchantBroadcastListStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (page) => emit(
        state.copyWith(
          status: MerchantBroadcastListStatus.success,
          broadcasts: page.content,
          page: page.page,
          hasMore: page.hasMore,
        ),
      ),
    );
  }

  Future<void> loadMore() async {
    if (!state.hasMore ||
        state.status == MerchantBroadcastListStatus.loadingMore) {
      return;
    }

    emit(state.copyWith(status: MerchantBroadcastListStatus.loadingMore));

    final result = await _getBroadcasts(page: state.page + 1, size: pageSize);

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: MerchantBroadcastListStatus.success,
          errorMessage: failure.message,
        ),
      ),
      (page) => emit(
        state.copyWith(
          status: MerchantBroadcastListStatus.success,
          broadcasts: [...state.broadcasts, ...page.content],
          page: page.page,
          hasMore: page.hasMore,
        ),
      ),
    );
  }
}
