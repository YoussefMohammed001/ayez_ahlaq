import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/use_cases/confirm_occurrence_use_case.dart';
import '../../domain/use_cases/dismiss_occurrence_use_case.dart';
import '../../domain/use_cases/get_money_summary_use_case.dart';
import '../../domain/use_cases/get_pending_occurrences_use_case.dart';
import 'money_home_state.dart';

class MoneyHomeCubit extends Cubit<MoneyHomeState> {
  final GetMoneySummaryUseCase _getSummary;
  final GetPendingOccurrencesUseCase _getPendingOccurrences;
  final ConfirmOccurrenceUseCase _confirmOccurrence;
  final DismissOccurrenceUseCase _dismissOccurrence;

  MoneyHomeCubit(
    this._getSummary,
    this._getPendingOccurrences,
    this._confirmOccurrence,
    this._dismissOccurrence,
  ) : super(const MoneyHomeState());

  Future<void> load() async {
    emit(state.copyWith(status: MoneyHomeStatus.loading));

    final summaryResult = await _getSummary();
    final occurrencesResult = await _getPendingOccurrences();

    if (summaryResult.isLeft()) {
      emit(
        state.copyWith(
          status: MoneyHomeStatus.failure,
          errorMessage: summaryResult.fold((f) => f.message, (_) => null),
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        status: MoneyHomeStatus.success,
        summary: summaryResult.fold((_) => null, (s) => s),
        pendingOccurrences: occurrencesResult.fold((_) => const [], (o) => o),
      ),
    );
  }

  Future<bool> confirmOccurrence(int id, {String? description, int? amount}) async {
    emit(
      state.copyWith(
        processingOccurrenceIds: {...state.processingOccurrenceIds, id},
      ),
    );
    final result = await _confirmOccurrence(
      id: id,
      description: description,
      amount: amount,
    );
    return result.fold(
      (failure) {
        emit(
          state.copyWith(
            processingOccurrenceIds: _without(id),
            errorMessage: failure.message,
          ),
        );
        return false;
      },
      (_) {
        _removeOccurrence(id);
        return true;
      },
    );
  }

  Future<bool> dismissOccurrence(int id) async {
    emit(
      state.copyWith(
        processingOccurrenceIds: {...state.processingOccurrenceIds, id},
      ),
    );
    final result = await _dismissOccurrence(id);
    return result.fold(
      (failure) {
        emit(
          state.copyWith(
            processingOccurrenceIds: _without(id),
            errorMessage: failure.message,
          ),
        );
        return false;
      },
      (_) {
        _removeOccurrence(id);
        return true;
      },
    );
  }

  void _removeOccurrence(int id) {
    emit(
      state.copyWith(
        processingOccurrenceIds: _without(id),
        pendingOccurrences:
            state.pendingOccurrences.where((o) => o.id != id).toList(),
      ),
    );
  }

  Set<int> _without(int id) =>
      state.processingOccurrenceIds.where((element) => element != id).toSet();
}
