import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/deduction_status.dart';
import '../../domain/use_cases/decide_deduction_use_case.dart';
import '../../domain/use_cases/get_pending_deductions_count_use_case.dart';
import '../../domain/use_cases/get_salary_deductions_use_case.dart';
import 'salary_deductions_state.dart';

class SalaryDeductionsCubit extends Cubit<SalaryDeductionsState> {
  final GetSalaryDeductionsUseCase _getDeductions;
  final DecideDeductionUseCase _decide;
  final GetPendingDeductionsCountUseCase _getPendingCount;

  SalaryDeductionsCubit(
    this._getDeductions,
    this._decide,
    this._getPendingCount,
  ) : super(const SalaryDeductionsState());

  @override
  void emit(SalaryDeductionsState state) {
    if (isClosed) return;
    super.emit(state);
  }

  Future<void> load() async {
    if (state.items.isEmpty) {
      emit(state.copyWith(status: SalaryDeductionsStatus.loading));
    }

    final pendingCount = _refreshPendingCount();
    final result = await _getDeductions(page: 0, status: state.filter);
    await pendingCount;

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: SalaryDeductionsStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (page) => emit(
        state.copyWith(
          status: SalaryDeductionsStatus.success,
          items: page.items,
          page: page.page,
          hasMore: page.hasMore,
        ),
      ),
    );
  }

  Future<void> setFilter(DeductionStatus? filter) async {
    emit(
      state.copyWith(
        filter: filter,
        clearFilter: filter == null,
        items: const [],
        status: SalaryDeductionsStatus.loading,
      ),
    );
    await load();
  }

  Future<void> loadMore() async {
    if (!state.hasMore || state.isLoadingMore) return;

    emit(state.copyWith(isLoadingMore: true));
    final result = await _getDeductions(
      page: state.page + 1,
      status: state.filter,
    );

    result.fold(
      (failure) => emit(
        state.copyWith(isLoadingMore: false, errorMessage: failure.message),
      ),
      (page) => emit(
        state.copyWith(
          items: [...state.items, ...page.items],
          page: page.page,
          hasMore: page.hasMore,
          isLoadingMore: false,
        ),
      ),
    );
  }

  Future<bool> decide(int id, {required bool waive, String? note}) async {
    emit(state.copyWith(isDeciding: true));

    final result = await _decide(id, waive: waive, note: note);
    final failure = result.fold((f) => f, (_) => null);

    if (failure != null) {
      emit(state.copyWith(isDeciding: false, errorMessage: failure.message));
      return false;
    }

    final updated = result.getOrElse(() => throw StateError('unreachable'));
    final keep = state.filter == null || state.filter == updated.status;

    emit(
      state.copyWith(
        isDeciding: false,
        items: [
          for (final item in state.items)
            if (item.id != id) item else if (keep) updated,
        ],
      ),
    );
    await _refreshPendingCount();
    return true;
  }

  Future<void> _refreshPendingCount() async {
    final result = await _getPendingCount();
    result.fold((_) {}, (count) => emit(state.copyWith(pendingCount: count)));
  }
}
