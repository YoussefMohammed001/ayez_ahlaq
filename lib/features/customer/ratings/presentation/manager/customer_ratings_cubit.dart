import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/use_cases/get_customer_ratings_use_case.dart';
import 'customer_ratings_state.dart';

class CustomerRatingsCubit extends Cubit<CustomerRatingsState> {
  final GetCustomerRatingsUseCase _getRatings;

  CustomerRatingsCubit(this._getRatings) : super(const CustomerRatingsState());

  Future<void> loadRatings() async {
    emit(state.copyWith(status: CustomerRatingsStatus.loading));

    final result = await _getRatings();

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: CustomerRatingsStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (ratings) => emit(
        state.copyWith(status: CustomerRatingsStatus.success, ratings: ratings),
      ),
    );
  }
}
