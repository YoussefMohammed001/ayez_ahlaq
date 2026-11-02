import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/use_cases/get_team_attendance_use_case.dart';
import 'attendance_team_state.dart';

class AttendanceTeamCubit extends Cubit<AttendanceTeamState> {
  final GetTeamAttendanceUseCase _getTeam;

  AttendanceTeamCubit(this._getTeam) : super(const AttendanceTeamState());

  @override
  void emit(AttendanceTeamState state) {
    if (isClosed) return;
    super.emit(state);
  }

  Future<void> load() async {
    if (state.fetchedAt == null) {
      emit(state.copyWith(status: AttendanceTeamStatus.loading));
    }

    final result = await _getTeam();

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: AttendanceTeamStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (members) => emit(
        state.copyWith(
          status: AttendanceTeamStatus.success,
          members: members,
          fetchedAt: DateTime.now(),
        ),
      ),
    );
  }
}
