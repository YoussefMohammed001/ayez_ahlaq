import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/use_cases/get_member_commission_use_case.dart';
import '../../domain/use_cases/set_member_commission_use_case.dart';
import 'member_commission_state.dart';

class MemberCommissionCubit extends Cubit<MemberCommissionState> {
  final GetMemberCommissionUseCase _get;
  final SetMemberCommissionUseCase _set;
  int? _memberId;

  MemberCommissionCubit(this._get, this._set)
    : super(const MemberCommissionState());

  @override
  void emit(MemberCommissionState state) {
    if (isClosed) return;
    super.emit(state);
  }

  Future<void> load(int memberId) async {
    _memberId = memberId;
    emit(state.copyWith(status: MemberCommissionStatus.loading));

    final result = await _get(memberId);
    result.fold(
      (failure) => emit(
        state.copyWith(
          status: MemberCommissionStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (commission) => emit(
        state.copyWith(
          status: MemberCommissionStatus.success,
          commission: commission,
        ),
      ),
    );
  }

  Future<bool> turnOn({double? percent}) =>
      _save(enabled: true, percent: percent);

  Future<bool> turnOff() => _save(enabled: false);

  Future<bool> _save({required bool enabled, double? percent}) async {
    emit(state.copyWith(isSaving: true));

    final result = await _set(_memberId!, enabled: enabled, percent: percent);
    return result.fold(
      (failure) {
        emit(state.copyWith(isSaving: false, errorMessage: failure.message));
        return false;
      },
      (commission) {
        emit(state.copyWith(isSaving: false, commission: commission));
        return true;
      },
    );
  }
}
