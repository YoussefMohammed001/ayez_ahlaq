import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/use_cases/get_earnings_use_case.dart';
import 'earnings_state.dart';

class EarningsCubit extends Cubit<EarningsState> {
  final GetEarningsUseCase _getEarnings;

  EarningsCubit(this._getEarnings) : super(const EarningsState());

  Future<void> loadEarnings() async {
    emit(state.copyWith(status: EarningsStatus.loading));

    final result = await _getEarnings();

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: EarningsStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (earnings) => emit(
        state.copyWith(status: EarningsStatus.success, earnings: earnings),
      ),
    );
  }
}
