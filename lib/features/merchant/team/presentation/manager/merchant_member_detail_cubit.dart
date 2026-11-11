import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/error/failure.dart';
import '../../domain/entities/merchant_member.dart';
import '../../domain/entities/merchant_member_permissions.dart';
import '../../domain/use_cases/activate_merchant_member_use_case.dart';
import '../../domain/use_cases/block_merchant_member_use_case.dart';
import '../../domain/use_cases/delete_merchant_member_use_case.dart';
import '../../domain/use_cases/get_merchant_member_use_case.dart';
import '../../domain/use_cases/reset_merchant_member_password_use_case.dart';
import '../../domain/use_cases/set_merchant_member_salary_use_case.dart';
import '../../domain/use_cases/update_merchant_member_permissions_use_case.dart';
import '../../domain/use_cases/update_merchant_member_use_case.dart';
import 'merchant_member_detail_state.dart';

class MerchantMemberDetailCubit extends Cubit<MerchantMemberDetailState> {
  final GetMerchantMemberUseCase _getMember;
  final UpdateMerchantMemberUseCase _updateMember;
  final SetMerchantMemberSalaryUseCase _setSalary;
  final UpdateMerchantMemberPermissionsUseCase _updatePermissions;
  final BlockMerchantMemberUseCase _block;
  final ActivateMerchantMemberUseCase _activate;
  final ResetMerchantMemberPasswordUseCase _resetPassword;
  final DeleteMerchantMemberUseCase _delete;

  MerchantMemberDetailCubit(
    this._getMember,
    this._updateMember,
    this._setSalary,
    this._updatePermissions,
    this._block,
    this._activate,
    this._resetPassword,
    this._delete,
  ) : super(const MerchantMemberDetailState());

  int? _requestedId;

  Future<void> load(int id) async {
    _requestedId = id;
    emit(
      const MerchantMemberDetailState(
        status: MerchantMemberDetailStatus.loading,
      ),
    );

    final result = await _getMember(id);
    if (_requestedId != id) return;

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: MerchantMemberDetailStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (member) => emit(
        state.copyWith(
          status: MerchantMemberDetailStatus.success,
          member: member,
        ),
      ),
    );
  }

  Future<void> reload() async {
    final id = _requestedId;
    if (id != null) await load(id);
  }

  Future<bool> updateMember({String? name, String? phoneNumber}) {
    return _applyMember(
      (id) => _updateMember(id: id, name: name, phoneNumber: phoneNumber),
    );
  }

  Future<bool> setSalary(double salary) =>
      _applyMember((id) => _setSalary(id, salary));

  Future<bool> setPermissions(MerchantMemberPermissions permissions) =>
      _applyMember((id) => _updatePermissions(id, permissions));

  Future<bool> blockMember() => _applyMember(_block.call);

  Future<bool> activateMember() => _applyMember(_activate.call);

  Future<bool> resetPassword() => _applyAction(_resetPassword.call);

  Future<bool> deleteMember() => _applyAction(_delete.call);

  Future<bool> _applyMember(
    Future<Either<Failure, MerchantMember>> Function(int id) action,
  ) async {
    final id = state.member?.id;
    if (id == null) return false;

    emit(state.copyWith(isSubmitting: true));

    final result = await action(id);

    return result.fold(
      (failure) {
        emit(
          state.copyWith(isSubmitting: false, errorMessage: failure.message),
        );
        return false;
      },
      (updated) {
        emit(state.copyWith(isSubmitting: false, member: updated));
        return true;
      },
    );
  }

  Future<bool> _applyAction(
    Future<Either<Failure, Unit>> Function(int id) action,
  ) async {
    final id = state.member?.id;
    if (id == null) return false;

    emit(state.copyWith(isSubmitting: true));

    final result = await action(id);

    final failure = result.fold((value) => value, (_) => null);
    emit(state.copyWith(isSubmitting: false, errorMessage: failure?.message));
    return failure == null;
  }
}
