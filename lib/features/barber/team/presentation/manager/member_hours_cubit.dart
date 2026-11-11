import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/error/failure.dart';
import '../../../hours/domain/entities/working_day.dart';
import 'member_hours_state.dart';

typedef LoadMemberHours =
    Future<Either<Failure, List<WorkingDay>>> Function(int memberId);

typedef SaveMemberHours =
    Future<Either<Failure, List<WorkingDay>>> Function(
      int memberId,
      List<WorkingDay> days,
    );

class MemberHoursCubit extends Cubit<MemberHoursState> {
  final LoadMemberHours _getHours;
  final SaveMemberHours _updateHours;

  MemberHoursCubit(this._getHours, this._updateHours)
    : super(const MemberHoursState());

  Future<void> loadHours(int memberId) async {
    emit(
      MemberHoursState(status: MemberHoursStatus.loading, memberId: memberId),
    );

    final result = await _getHours(memberId);

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: MemberHoursStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (days) =>
          emit(state.copyWith(status: MemberHoursStatus.success, days: days)),
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
    final memberId = state.memberId;
    if (memberId == null) return false;

    emit(state.copyWith(isSubmitting: true));

    final result = await _updateHours(memberId, state.days);

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
            status: MemberHoursStatus.success,
            days: days,
          ),
        );
        return true;
      },
    );
  }
}
