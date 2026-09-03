import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/use_cases/get_barber_reviews_use_case.dart';
import 'barber_reviews_state.dart';

class BarberReviewsCubit extends Cubit<BarberReviewsState> {
  final GetBarberReviewsUseCase _getReviews;

  BarberReviewsCubit(this._getReviews) : super(const BarberReviewsState());

  Future<void> loadReviews() async {
    emit(state.copyWith(status: BarberReviewsStatus.loading));

    final result = await _getReviews();

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: BarberReviewsStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (summary) => emit(
        state.copyWith(status: BarberReviewsStatus.success, summary: summary),
      ),
    );
  }
}
