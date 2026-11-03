import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/use_cases/activate_team_member_use_case.dart';
import '../../domain/use_cases/block_team_member_use_case.dart';
import '../../domain/use_cases/delete_team_member_permanently_use_case.dart';
import '../../domain/use_cases/get_team_member_use_case.dart';
import '../../domain/use_cases/reset_member_password_use_case.dart';
import '../../domain/use_cases/set_member_availability_use_case.dart';
import '../../domain/use_cases/update_member_permissions_use_case.dart';
import '../../domain/use_cases/update_team_member_use_case.dart';
import '../../../profile/domain/entities/barber_permissions.dart';
import 'team_member_detail_state.dart';

class TeamMemberDetailCubit extends Cubit<TeamMemberDetailState> {
  final GetTeamMemberUseCase _getMember;
  final UpdateTeamMemberUseCase _updateMember;
  final SetMemberAvailabilityUseCase _setAvailability;
  final BlockTeamMemberUseCase _blockMember;
  final ActivateTeamMemberUseCase _activateMember;
  final DeleteTeamMemberPermanentlyUseCase _deleteMemberPermanently;
  final UpdateMemberPermissionsUseCase _updatePermissions;
  final ResetMemberPasswordUseCase _resetPassword;

  TeamMemberDetailCubit(
    this._getMember,
    this._updateMember,
    this._setAvailability,
    this._blockMember,
    this._activateMember,
    this._deleteMemberPermanently,
    this._updatePermissions,
    this._resetPassword,
  ) : super(const TeamMemberDetailState());

  int? _requestedMemberId;

  Future<void> loadMember(int id) async {
    _requestedMemberId = id;
    emit(const TeamMemberDetailState(status: TeamMemberDetailStatus.loading));

    final result = await _getMember(id);
    if (_requestedMemberId != id) return;

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: TeamMemberDetailStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (member) => emit(
        state.copyWith(status: TeamMemberDetailStatus.success, member: member),
      ),
    );
  }

  Future<void> reload() async {
    final id = _requestedMemberId;
    if (id != null) await loadMember(id);
  }

  Future<bool> updateMember(String name, String tagline) async {
    final member = state.member;
    if (member == null) return false;

    emit(state.copyWith(isSubmitting: true));

    final result = await _updateMember(id: member.id, name: name, tagline: tagline);

    return result.fold(
      (failure) {
        emit(state.copyWith(isSubmitting: false, errorMessage: failure.message));
        return false;
      },
      (updated) {
        emit(state.copyWith(isSubmitting: false, member: updated));
        return true;
      },
    );
  }

  Future<void> setAvailability(bool available) async {
    final member = state.member;
    if (member == null || state.isSubmitting) return;

    emit(
      state.copyWith(
        isSubmitting: true,
        member: member.copyWith(available: available),
      ),
    );

    final result = await _setAvailability(member.id, available);

    result.fold(
      (failure) => emit(
        state.copyWith(
          isSubmitting: false,
          member: member,
          errorMessage: failure.message,
        ),
      ),
      (updated) => emit(state.copyWith(isSubmitting: false, member: updated)),
    );
  }

  Future<void> blockMember() async {
    final member = state.member;
    if (member == null) return;

    emit(state.copyWith(isSubmitting: true));

    final result = await _blockMember(member.id);

    result.fold(
      (failure) => emit(state.copyWith(isSubmitting: false, errorMessage: failure.message)),
      (updated) => emit(state.copyWith(isSubmitting: false, member: updated)),
    );
  }

  Future<void> activateMember() async {
    final member = state.member;
    if (member == null) return;

    emit(state.copyWith(isSubmitting: true));

    final result = await _activateMember(member.id);

    result.fold(
      (failure) => emit(state.copyWith(isSubmitting: false, errorMessage: failure.message)),
      (updated) => emit(state.copyWith(isSubmitting: false, member: updated)),
    );
  }

  Future<void> setPermissions(BarberPermissions permissions) async {
    final member = state.member;
    if (member == null) return;

    emit(state.copyWith(isSubmitting: true));

    final result = await _updatePermissions(member.id, permissions);

    result.fold(
      (failure) => emit(
        state.copyWith(isSubmitting: false, errorMessage: failure.message),
      ),
      (saved) => emit(
        state.copyWith(
          isSubmitting: false,
          member: member.copyWith(permissions: saved),
        ),
      ),
    );
  }

  Future<bool> resetPassword(String tempPassword) async {
    final member = state.member;
    if (member == null) return false;

    emit(state.copyWith(isSubmitting: true));

    final result = await _resetPassword(member.id, tempPassword);

    return result.fold(
      (failure) {
        emit(state.copyWith(isSubmitting: false, errorMessage: failure.message));
        return false;
      },
      (_) {
        emit(state.copyWith(isSubmitting: false));
        return true;
      },
    );
  }

  Future<bool> deleteMemberPermanently() async {
    final member = state.member;
    if (member == null) return false;

    emit(state.copyWith(isSubmitting: true));

    final result = await _deleteMemberPermanently(member.id);

    return result.fold(
      (failure) {
        emit(state.copyWith(isSubmitting: false, errorMessage: failure.message));
        return false;
      },
      (_) {
        emit(state.copyWith(isSubmitting: false));
        return true;
      },
    );
  }
}
