import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/use_cases/change_money_pin_use_case.dart';
import '../../domain/use_cases/check_money_pin_use_case.dart';
import '../../domain/use_cases/get_money_pin_reset_status_use_case.dart';
import '../../domain/use_cases/request_money_pin_reset_use_case.dart';
import '../../domain/use_cases/setup_money_pin_use_case.dart';
import '../../domain/use_cases/verify_money_pin_use_case.dart';
import 'money_pin_state.dart';

class MoneyPinCubit extends Cubit<MoneyPinState> {
  final CheckMoneyPinUseCase _checkPin;
  final SetupMoneyPinUseCase _setupPin;
  final VerifyMoneyPinUseCase _verifyPin;
  final ChangeMoneyPinUseCase _changePin;
  final GetMoneyPinResetStatusUseCase _getResetStatus;
  final RequestMoneyPinResetUseCase _requestReset;

  MoneyPinCubit(
    this._checkPin,
    this._setupPin,
    this._verifyPin,
    this._changePin,
    this._getResetStatus,
    this._requestReset,
  ) : super(const MoneyPinState());

  Future<void> checkStatus() async {
    emit(state.copyWith(stage: MoneyPinStage.checking));
    final result = await _checkPin();
    result.fold(
      (failure) => emit(
        state.copyWith(stage: MoneyPinStage.error, errorMessage: failure.message),
      ),
      (hasPin) => emit(
        state.copyWith(
          stage: hasPin ? MoneyPinStage.locked : MoneyPinStage.needsSetup,
        ),
      ),
    );
  }

  Future<bool> setup(String pin) async {
    emit(state.copyWith(submitting: true, errorMessage: null));
    final result = await _setupPin(pin);
    return result.fold(
      (failure) {
        emit(state.copyWith(submitting: false, errorMessage: failure.message));
        return false;
      },
      (_) {
        emit(state.copyWith(submitting: false, stage: MoneyPinStage.unlocked));
        return true;
      },
    );
  }

  Future<bool> verify(String pin) async {
    emit(state.copyWith(submitting: true, errorMessage: null));
    final result = await _verifyPin(pin);
    return result.fold(
      (failure) {
        emit(state.copyWith(submitting: false, errorMessage: failure.message));
        return false;
      },
      (_) {
        emit(state.copyWith(submitting: false, stage: MoneyPinStage.unlocked));
        return true;
      },
    );
  }

  Future<bool> change({required String currentPin, required String newPin}) async {
    emit(state.copyWith(submitting: true, errorMessage: null));
    final result = await _changePin(currentPin: currentPin, newPin: newPin);
    return result.fold(
      (failure) {
        emit(state.copyWith(submitting: false, errorMessage: failure.message));
        return false;
      },
      (_) {
        emit(state.copyWith(submitting: false));
        return true;
      },
    );
  }

  void lock() => emit(state.copyWith(stage: MoneyPinStage.locked));

  Future<void> checkResetStatus() async {
    emit(state.copyWith(checkingResetStatus: true));
    final result = await _getResetStatus();
    result.fold(
      (failure) => emit(
        state.copyWith(checkingResetStatus: false, errorMessage: failure.message),
      ),
      (status) => emit(
        state.copyWith(checkingResetStatus: false, resetStatus: status),
      ),
    );
  }

  Future<bool> requestReset() async {
    emit(state.copyWith(submitting: true, errorMessage: null));
    final result = await _requestReset();
    return result.fold(
      (failure) {
        emit(state.copyWith(submitting: false, errorMessage: failure.message));
        return false;
      },
      (status) {
        emit(state.copyWith(submitting: false, resetStatus: status));
        return true;
      },
    );
  }
}
