import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../hours/domain/entities/working_day.dart';
import '../../domain/use_cases/get_home_service_hours_use_case.dart';
import '../../domain/use_cases/update_home_service_hours_use_case.dart';
import 'home_service_hours_state.dart';

class HomeServiceHoursCubit extends Cubit<HomeServiceHoursState> {
  final GetHomeServiceHoursUseCase _getHours;
  final UpdateHomeServiceHoursUseCase _updateHours;

  HomeServiceHoursCubit(this._getHours, this._updateHours)
    : super(const HomeServiceHoursState());

  Future<void> loadHours() async {
    emit(state.copyWith(status: HomeServiceHoursStatus.loading));

    final result = await _getHours();

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: HomeServiceHoursStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (days) => emit(
        state.copyWith(status: HomeServiceHoursStatus.success, days: days),
      ),
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
            status: HomeServiceHoursStatus.success,
            days: days,
          ),
        );
        return true;
      },
    );
  }
}
