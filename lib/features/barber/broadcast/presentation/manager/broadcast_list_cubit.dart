import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/use_cases/get_broadcasts_use_case.dart';
import 'broadcast_list_state.dart';

class BroadcastListCubit extends Cubit<BroadcastListState> {
  static const int pageSize = 20;

  final GetBroadcastsUseCase _getBroadcasts;

  BroadcastListCubit(this._getBroadcasts) : super(const BroadcastListState());

  Future<void> loadBroadcasts() async {
    emit(state.copyWith(status: BroadcastListStatus.loading));

    final result = await _getBroadcasts(page: 0, size: pageSize);

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: BroadcastListStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (page) => emit(
        state.copyWith(
          status: BroadcastListStatus.success,
          broadcasts: page.content,
          page: page.page,
          hasMore: page.hasMore,
        ),
      ),
    );
  }

  Future<void> loadMore() async {
    if (!state.hasMore || state.status == BroadcastListStatus.loadingMore) {
      return;
    }

    emit(state.copyWith(status: BroadcastListStatus.loadingMore));

    final result = await _getBroadcasts(page: state.page + 1, size: pageSize);

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: BroadcastListStatus.success,
          errorMessage: failure.message,
        ),
      ),
      (page) => emit(
        state.copyWith(
          status: BroadcastListStatus.success,
          broadcasts: [...state.broadcasts, ...page.content],
          page: page.page,
          hasMore: page.hasMore,
        ),
      ),
    );
  }
}
