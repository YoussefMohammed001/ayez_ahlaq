import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/use_cases/get_pending_visit_rating_use_case.dart';
import '../../domain/use_cases/submit_visit_rating_use_case.dart';
import 'pending_visit_rating_state.dart';

class PendingVisitRatingCubit extends Cubit<PendingVisitRatingState> {
  final GetPendingVisitRatingUseCase _getPending;
  final SubmitVisitRatingUseCase _submit;

  PendingVisitRatingCubit(this._getPending, this._submit)
    : super(const PendingVisitRatingState());

  Future<void> check() async {
    emit(state.copyWith(status: PendingVisitRatingStatus.checking));

    final result = await _getPending();

    result.fold(
      (_) => emit(const PendingVisitRatingState()),
      (pending) => emit(
        pending == null
            ? const PendingVisitRatingState()
            : PendingVisitRatingState(
                status: PendingVisitRatingStatus.ready,
                pending: pending,
              ),
      ),
    );
  }

  Future<void> submit({
    int? barberStars,
    String? barberNote,
    int? shopStars,
  }) async {
    final pending = state.pending;
    if (pending == null) return;

    emit(state.copyWith(status: PendingVisitRatingStatus.submitting));

    final result = await _submit(
      pending: pending,
      barberStars: barberStars,
      barberNote: barberNote,
      shopStars: shopStars,
    );

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: PendingVisitRatingStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (_) => emit(state.copyWith(status: PendingVisitRatingStatus.submitted)),
    );
  }
}
