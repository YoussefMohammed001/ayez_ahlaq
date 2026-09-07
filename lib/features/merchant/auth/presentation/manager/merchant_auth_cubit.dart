import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/network/constants/http_codes.dart';
import '../../data/requests/register_request.dart';
import '../../domain/use_cases/forgot_merchant_password_use_case.dart';
import '../../domain/use_cases/merchant_login_use_case.dart';
import '../../domain/use_cases/merchant_logout_use_case.dart';
import '../../domain/use_cases/merchant_register_use_case.dart';
import '../../domain/use_cases/resend_merchant_register_otp_use_case.dart';
import '../../domain/use_cases/reset_merchant_password_use_case.dart';
import '../../domain/use_cases/verify_merchant_password_otp_use_case.dart';
import '../../domain/use_cases/verify_merchant_register_otp_use_case.dart';
import 'merchant_auth_state.dart';

class MerchantAuthCubit extends Cubit<MerchantAuthState> {
  final MerchantLoginUseCase _login;
  final MerchantRegisterUseCase _register;
  final VerifyMerchantRegisterOtpUseCase _verifyRegisterOtp;
  final ResendMerchantRegisterOtpUseCase _resendRegisterOtp;
  final ForgotMerchantPasswordUseCase _forgotPassword;
  final VerifyMerchantPasswordOtpUseCase _verifyPasswordOtp;
  final ResetMerchantPasswordUseCase _resetPassword;
  final MerchantLogoutUseCase _logout;

  MerchantAuthCubit(
    this._login,
    this._register,
    this._verifyRegisterOtp,
    this._resendRegisterOtp,
    this._forgotPassword,
    this._verifyPasswordOtp,
    this._resetPassword,
    this._logout,
  ) : super(const MerchantAuthState());

  Future<void> login(String phone, String password) async {
    emit(state.copyWith(status: AuthStatus.submitting));

    final result = await _login(phone, password);

    result.fold((failure) {
      if (failure.statusCode == HttpCodes.forbidden) {
        emit(
          state.copyWith(status: AuthStatus.otpRequested, pendingPhone: phone),
        );
        return;
      }
      _emitFailure(failure);
    }, (_) => emit(state.copyWith(status: AuthStatus.authenticated)));
  }

  Future<void> register(RegisterRequest request) async {
    emit(state.copyWith(status: AuthStatus.submitting));

    final result = await _register(request);

    result.fold(
      _emitFailure,
      (_) => emit(
        state.copyWith(
          status: AuthStatus.otpRequested,
          pendingPhone: request.phoneNumber,
        ),
      ),
    );
  }

  bool get canResendRegisterOtp => state.pendingPhone.isNotEmpty;

  Future<void> resendRegisterOtp() async {
    if (state.pendingPhone.isEmpty) return;

    emit(state.copyWith(status: AuthStatus.submitting));

    final result = await _resendRegisterOtp(state.pendingPhone);

    result.fold(
      _emitFailure,
      (message) =>
          emit(state.copyWith(status: AuthStatus.otpResent, infoMessage: message)),
    );
  }

  Future<void> verifyRegisterOtp(String otp) async {
    emit(state.copyWith(status: AuthStatus.submitting));

    final result = await _verifyRegisterOtp(state.pendingPhone, otp);

    result.fold(
      _emitFailure,
      (_) => emit(state.copyWith(status: AuthStatus.authenticated)),
    );
  }

  Future<void> forgotPassword(String phone) async {
    emit(state.copyWith(status: AuthStatus.submitting));

    final result = await _forgotPassword(phone);

    result.fold(
      _emitFailure,
      (_) => emit(
        state.copyWith(status: AuthStatus.otpRequested, pendingPhone: phone),
      ),
    );
  }

  Future<void> verifyPasswordOtp(String code) async {
    emit(state.copyWith(status: AuthStatus.submitting));

    final result = await _verifyPasswordOtp(state.pendingPhone, code);

    result.fold(
      _emitFailure,
      (ticket) => emit(
        state.copyWith(
          status: AuthStatus.otpVerified,
          resetToken: ticket.resetToken,
        ),
      ),
    );
  }

  Future<void> resetPassword(String newPassword) async {
    emit(state.copyWith(status: AuthStatus.submitting));

    final result = await _resetPassword(state.resetToken, newPassword);

    result.fold(
      _emitFailure,
      (_) => emit(state.copyWith(status: AuthStatus.passwordReset)),
    );
  }

  Future<void> logout() async {
    await _logout();
    emit(const MerchantAuthState());
  }

  void _emitFailure(Failure failure) => emit(
    state.copyWith(status: AuthStatus.failure, errorMessage: failure.message),
  );

  void resetStatus() =>
      emit(state.copyWith(status: AuthStatus.initial, errorMessage: null));
}
