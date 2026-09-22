import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/money_direction.dart';
import '../../domain/use_cases/create_money_entry_use_case.dart';
import '../../domain/use_cases/get_money_entries_use_case.dart';
import 'money_entries_state.dart';

class MoneyEntriesCubit extends Cubit<MoneyEntriesState> {
  static const int pageSize = 20;

  final GetMoneyEntriesUseCase _getEntries;
  final CreateMoneyEntryUseCase _createEntry;

  MoneyEntriesCubit(this._getEntries, this._createEntry)
    : super(const MoneyEntriesState());

  Future<void> load() async {
    emit(state.copyWith(status: MoneyEntriesStatus.loading));
    final result = await _getEntries(page: 0, size: pageSize);
    result.fold(
      (failure) => emit(
        state.copyWith(status: MoneyEntriesStatus.failure, errorMessage: failure.message),
      ),
      (page) => emit(
        state.copyWith(
          status: MoneyEntriesStatus.success,
          entries: page.content,
          page: page.page,
          hasMore: page.hasMore,
        ),
      ),
    );
  }

  Future<void> loadMore() async {
    if (!state.hasMore || state.status == MoneyEntriesStatus.loadingMore) return;

    emit(state.copyWith(status: MoneyEntriesStatus.loadingMore));
    final result = await _getEntries(page: state.page + 1, size: pageSize);
    result.fold(
      (failure) => emit(
        state.copyWith(status: MoneyEntriesStatus.success, errorMessage: failure.message),
      ),
      (page) => emit(
        state.copyWith(
          status: MoneyEntriesStatus.success,
          entries: [...state.entries, ...page.content],
          page: page.page,
          hasMore: page.hasMore,
        ),
      ),
    );
  }

  Future<bool> createEntry({
    required String description,
    required int amount,
    required MoneyDirection direction,
    DateTime? entryDate,
  }) async {
    emit(state.copyWith(isSubmitting: true));
    final result = await _createEntry(
      description: description,
      amount: amount,
      direction: direction,
      entryDate: entryDate,
    );
    return result.fold(
      (failure) {
        emit(state.copyWith(isSubmitting: false, errorMessage: failure.message));
        return false;
      },
      (entry) {
        emit(
          state.copyWith(isSubmitting: false, entries: [entry, ...state.entries]),
        );
        return true;
      },
    );
  }
}
