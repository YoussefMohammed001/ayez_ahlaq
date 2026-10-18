import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../profile/domain/entities/barber_permissions.dart';
import '../../domain/use_cases/update_member_permissions_use_case.dart';
import '../../domain/entities/team_member_detail.dart';
import '../../domain/use_cases/add_team_member_use_case.dart';
import '../../domain/use_cases/get_team_use_case.dart';
import 'barber_team_state.dart';

class BarberTeamCubit extends Cubit<BarberTeamState> {
  final GetTeamUseCase _getTeam;
  final AddTeamMemberUseCase _addMember;
  final UpdateMemberPermissionsUseCase _updatePermissions;

  BarberTeamCubit(this._getTeam, this._addMember, this._updatePermissions)
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

  Future<({TeamMemberDetail? member, bool permissionsSaved})> addMember({
    required String name,
    required String phoneNumber,
    String? tagline,
    BarberPermissions permissions = BarberPermissions.none,
  }) async {
    emit(state.copyWith(isSubmitting: true));

    final result = await _addMember(
      name: name,
      phoneNumber: phoneNumber,
      tagline: tagline,
    );

    final member = result.fold((failure) {
      emit(state.copyWith(isSubmitting: false, errorMessage: failure.message));
      return null;
    }, (added) => added);

    if (member == null) return (member: null, permissionsSaved: false);

    final permissionsSaved = await _savePermissions(member.id, permissions);
    emit(state.copyWith(isSubmitting: false));
    loadTeam();
    return (member: member, permissionsSaved: permissionsSaved);
  }

  Future<bool> _savePermissions(int id, BarberPermissions permissions) async {
    if (permissions == BarberPermissions.none) return true;
    final result = await _updatePermissions(id, permissions);
    return result.isRight();
  }
}
