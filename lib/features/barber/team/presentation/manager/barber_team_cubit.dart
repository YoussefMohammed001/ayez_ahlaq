import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/team_member_detail.dart';
import '../../domain/use_cases/add_team_member_use_case.dart';
import '../../domain/use_cases/get_team_use_case.dart';
import 'barber_team_state.dart';

class BarberTeamCubit extends Cubit<BarberTeamState> {
  final GetTeamUseCase _getTeam;
  final AddTeamMemberUseCase _addMember;

  BarberTeamCubit(this._getTeam, this._addMember)
    : super(const BarberTeamState());

  Future<void> loadTeam() async {
    emit(state.copyWith(status: BarberTeamStatus.loading));

    final result = await _getTeam();

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: BarberTeamStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (members) => emit(
        state.copyWith(status: BarberTeamStatus.success, members: members),
      ),
    );
  }

  Future<TeamMemberDetail?> addMember({
    required String name,
    required String phoneNumber,
    String? tagline,
  }) async {
    emit(state.copyWith(isSubmitting: true));

    final result = await _addMember(
      name: name,
      phoneNumber: phoneNumber,
      tagline: tagline,
    );

    return result.fold(
      (failure) {
        emit(
          state.copyWith(isSubmitting: false, errorMessage: failure.message),
        );
        return null;
      },
      (member) {
        emit(state.copyWith(isSubmitting: false));
        loadTeam();
        return member;
      },
    );
  }
}
