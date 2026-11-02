import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/network/constants/http_codes.dart';
import '../../../../../shared/auth/domain/entities/register_outcome.dart';
import '../../data/requests/barber_register_request.dart';
import '../../domain/use_cases/barber_login_use_case.dart';
import '../../domain/use_cases/barber_logout_use_case.dart';
import '../../domain/use_cases/barber_register_use_case.dart';
import '../../domain/use_cases/forgot_barber_password_use_case.dart';
import '../../domain/use_cases/resend_barber_register_otp_use_case.dart';
import '../../domain/use_cases/reset_barber_password_use_case.dart';
import '../../domain/use_cases/verify_barber_password_otp_use_case.dart';
import '../../domain/use_cases/verify_barber_register_otp_use_case.dart';
import 'barber_auth_state.dart';

class BarberAuthCubit extends Cubit<BarberAuthState> {
  final BarberLoginUseCase _login;
  final BarberRegisterUseCase _register;
  final VerifyBarberRegisterOtpUseCase _verifyRegisterOtp;
  final ResendBarberRegisterOtpUseCase _resendRegisterOtp;
  final ForgotBarberPasswordUseCase _forgotPassword;
  final VerifyBarberPasswordOtpUseCase _verifyPasswordOtp;
  final ResetBarberPasswordUseCase _resetPassword;
  final BarberLogoutUseCase _logout;

  BarberAuthCubit(
    this._login,
    this._register,
    this._verifyRegisterOtp,
    this._resendRegisterOtp,
    this._forgotPassword,
    this._verifyPasswordOtp,
    this._resetPassword,
    this._logout,
  ) : super(const BarberAuthState());

  Future<void> login(String identifier, String password) async {
    emit(state.copyWith(status: BarberAuthStatus.submitting));

    final result = await _login(identifier, password);

    result.fold((failure) {
      if (failure.statusCode == HttpCodes.forbidden) {
        emit(
          state.copyWith(
            status: BarberAuthStatus.otpRequested,
            pendingPhone: identifier,
          ),
        );
        return;
      }
      _emitFailure(failure);
    }, (_) => emit(state.copyWith(status: BarberAuthStatus.authenticated)));
  }

  Future<void> register(BarberRegisterRequest request) async {
    emit(state.copyWith(status: BarberAuthStatus.submitting));

    final result = await _register(request);

    result.fold(
      _emitFailure,
      (outcome) => emit(
        outcome == RegisterOutcome.signedIn
            ? state.copyWith(status: BarberAuthStatus.authenticated)
            : state.copyWith(
                status: BarberAuthStatus.otpRequested,
                pendingPhone: request.phoneNumber,
              ),
      ),
    );
  }

  bool get canResendRegisterOtp => state.pendingPhone.isNotEmpty;

  Future<void> resendRegisterOtp() async {
    if (state.pendingPhone.isEmpty) return;

    emit(state.copyWith(status: BarberAuthStatus.submitting));

    final result = await _resendRegisterOtp(state.pendingPhone);

    result.fold(
      _emitFailure,
      (message) => emit(
        state.copyWith(status: BarberAuthStatus.otpResent, infoMessage: message),
      ),
    );
  }

  Future<void> verifyRegisterOtp(String otp) async {
    emit(state.copyWith(status: BarberAuthStatus.submitting));

    final result = await _verifyRegisterOtp(state.pendingPhone, otp);

    result.fold(
      _emitFailure,
      (_) => emit(state.copyWith(status: BarberAuthStatus.authenticated)),
    );
  }

  Future<void> forgotPassword(String phone) async {
    emit(state.copyWith(status: BarberAuthStatus.submitting));

    final result = await _forgotPassword(phone);

    result.fold(
      _emitFailure,
      (_) => emit(
        state.copyWith(
          status: BarberAuthStatus.otpRequested,
          pendingPhone: phone,
        ),
      ),
    );
  }

  Future<void> verifyPasswordOtp(String code) async {
    emit(state.copyWith(status: BarberAuthStatus.submitting));

    final result = await _verifyPasswordOtp(state.pendingPhone, code);

    result.fold(
      _emitFailure,
      (ticket) => emit(
        state.copyWith(
          status: BarberAuthStatus.otpVerified,
          resetToken: ticket.resetToken,
        ),
      ),
    );
  }

  Future<void> resetPassword(String newPassword) async {
    emit(state.copyWith(status: BarberAuthStatus.submitting));

    final result = await _resetPassword(state.resetToken, newPassword);

    result.fold(
      _emitFailure,
      (_) => emit(state.copyWith(status: BarberAuthStatus.passwordReset)),
    );
  }

  Future<void> logout() async {
    await _logout();
    emit(const BarberAuthState());
  }

  void _emitFailure(Failure failure) => emit(
    state.copyWith(
      status: BarberAuthStatus.failure,
      errorMessage: failure.message,
    ),
  );

  void resetStatus() => emit(
    state.copyWith(status: BarberAuthStatus.initial, errorMessage: null),
  );
}
