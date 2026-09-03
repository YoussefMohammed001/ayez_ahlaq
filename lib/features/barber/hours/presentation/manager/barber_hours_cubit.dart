import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/working_day.dart';
import '../../domain/use_cases/get_barber_hours_use_case.dart';
import '../../domain/use_cases/update_barber_hours_use_case.dart';
import 'barber_hours_state.dart';

class BarberHoursCubit extends Cubit<BarberHoursState> {
  final GetBarberHoursUseCase _getHours;
  final UpdateBarberHoursUseCase _updateHours;

  BarberHoursCubit(this._getHours, this._updateHours)
    : super(const BarberHoursState());

  Future<void> loadHours() async {
    emit(state.copyWith(status: BarberHoursStatus.loading));

    final result = await _getHours();

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: BarberHoursStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (days) =>
          emit(state.copyWith(status: BarberHoursStatus.success, days: days)),
    );
  }

  void updateDay(int dayOfWeek, WorkingDay Function(WorkingDay) update) {
    emit(
      state.copyWith(
        days: [
          for (final day in state.days)
            if (day.dayOfWeek == dayOfWeek) update(day) else day,
        ],
      ),
    );
  }

  Future<bool> saveHours() async {
    emit(state.copyWith(isSubmitting: true));

    final result = await _updateHours(state.days);

    return result.fold(
      (failure) {
        emit(
          state.copyWith(isSubmitting: false, errorMessage: failure.message),
        );
        return false;
      },
      (days) {
        emit(
          state.copyWith(
            isSubmitting: false,
            status: BarberHoursStatus.success,
            days: days,
          ),
        );
        return true;
      },
    );
  }
}
