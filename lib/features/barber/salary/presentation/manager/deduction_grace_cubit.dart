import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/use_cases/get_deduction_grace_use_case.dart';
import '../../domain/use_cases/set_deduction_grace_use_case.dart';
import 'deduction_grace_state.dart';

class DeductionGraceCubit extends Cubit<DeductionGraceState> {
  final GetDeductionGraceUseCase _getGrace;
  final SetDeductionGraceUseCase _setGrace;

  DeductionGraceCubit(this._getGrace, this._setGrace)
    : super(const DeductionGraceState());

  @override
  void emit(DeductionGraceState state) {
    if (isClosed) return;
    super.emit(state);
  }

  Future<void> load() async {
    emit(state.copyWith(status: DeductionGraceStatus.loading));

    final result = await _getGrace();
    result.fold(
      (failure) => emit(
        state.copyWith(
          status: DeductionGraceStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (minutes) => emit(
        state.copyWith(status: DeductionGraceStatus.success, minutes: minutes),
      ),
    );
  }

  Future<bool> save(int minutes) async {
    emit(state.copyWith(isSaving: true));

    final result = await _setGrace(minutes);
    return result.fold(
      (failure) {
        emit(state.copyWith(isSaving: false, errorMessage: failure.message));
        return false;
      },
      (saved) {
        emit(state.copyWith(isSaving: false, minutes: saved));
        return true;
      },
    );
  }
}
