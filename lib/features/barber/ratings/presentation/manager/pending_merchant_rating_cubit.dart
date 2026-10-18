import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/use_cases/get_pending_merchant_rating_use_case.dart';
import '../../domain/use_cases/submit_merchant_rating_use_case.dart';
import 'pending_merchant_rating_state.dart';

class PendingMerchantRatingCubit extends Cubit<PendingMerchantRatingState> {
  final GetPendingMerchantRatingUseCase _getPending;
  final SubmitMerchantRatingUseCase _submit;

  PendingMerchantRatingCubit(this._getPending, this._submit)
    : super(const PendingMerchantRatingState());

  Future<void> check() async {
    emit(state.copyWith(status: PendingMerchantRatingStatus.checking));

    final result = await _getPending();

    result.fold(
      (_) => emit(const PendingMerchantRatingState()),
      (pending) => emit(
        pending == null
            ? const PendingMerchantRatingState()
            : PendingMerchantRatingState(
                status: PendingMerchantRatingStatus.ready,
                pending: pending,
              ),
      ),
    );
  }

  Future<void> submit({required int stars, String? note}) async {
    final pending = state.pending;
    if (pending == null) return;

    emit(state.copyWith(status: PendingMerchantRatingStatus.submitting));

    final result = await _submit(
      orderId: pending.orderId,
      stars: stars,
      note: note,
    );

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: PendingMerchantRatingStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (_) => emit(state.copyWith(status: PendingMerchantRatingStatus.submitted)),
    );
  }
}
