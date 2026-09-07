import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/network/constants/http_codes.dart';
import '../../data/requests/customer_register_request.dart';
import '../../domain/use_cases/customer_login_use_case.dart';
import '../../domain/use_cases/customer_logout_use_case.dart';
import '../../domain/use_cases/customer_register_use_case.dart';
import '../../domain/use_cases/forgot_customer_password_use_case.dart';
import '../../domain/use_cases/resend_customer_register_otp_use_case.dart';
import '../../domain/use_cases/reset_customer_password_use_case.dart';
import '../../domain/use_cases/verify_customer_password_otp_use_case.dart';
import '../../domain/use_cases/verify_customer_register_otp_use_case.dart';
import 'customer_auth_state.dart';

class CustomerAuthCubit extends Cubit<CustomerAuthState> {
  final CustomerLoginUseCase _login;
  final CustomerRegisterUseCase _register;
  final VerifyCustomerRegisterOtpUseCase _verifyRegisterOtp;
  final ResendCustomerRegisterOtpUseCase _resendRegisterOtp;
  final ForgotCustomerPasswordUseCase _forgotPassword;
  final VerifyCustomerPasswordOtpUseCase _verifyPasswordOtp;
  final ResetCustomerPasswordUseCase _resetPassword;
  final CustomerLogoutUseCase _logout;

  CustomerAuthCubit(
    this._login,
    this._register,
    this._verifyRegisterOtp,
    this._resendRegisterOtp,
    this._forgotPassword,
    this._verifyPasswordOtp,
    this._resetPassword,
    this._logout,
  ) : super(const CustomerAuthState());

  Future<void> login(String identifier, String password) async {
    emit(state.copyWith(status: CustomerAuthStatus.submitting));

    final result = await _login(identifier, password);

    result.fold((failure) {
      if (failure.statusCode == HttpCodes.forbidden) {
        emit(
          state.copyWith(
            status: CustomerAuthStatus.otpRequested,
            pendingPhone: identifier,
          ),
        );
        return;
      }
      _emitFailure(failure);
    }, (_) => emit(state.copyWith(status: CustomerAuthStatus.authenticated)));
  }

  Future<void> register(CustomerRegisterRequest request) async {
    emit(state.copyWith(status: CustomerAuthStatus.submitting));

    final result = await _register(request);

    result.fold(
      _emitFailure,
      (_) => emit(
        state.copyWith(
          status: CustomerAuthStatus.otpRequested,
          pendingPhone: request.phoneNumber,
        ),
      ),
    );
  }

  bool get canResendRegisterOtp => state.pendingPhone.isNotEmpty;

  Future<void> resendRegisterOtp() async {
    if (state.pendingPhone.isEmpty) return;

    emit(state.copyWith(status: CustomerAuthStatus.submitting));

    final result = await _resendRegisterOtp(state.pendingPhone);

    result.fold(
      _emitFailure,
      (message) => emit(
        state.copyWith(
          status: CustomerAuthStatus.otpResent,
          infoMessage: message,
        ),
      ),
    );
  }

  Future<void> verifyRegisterOtp(String otp) async {
    emit(state.copyWith(status: CustomerAuthStatus.submitting));

    final result = await _verifyRegisterOtp(state.pendingPhone, otp);

    result.fold(
      _emitFailure,
      (_) => emit(state.copyWith(status: CustomerAuthStatus.authenticated)),
    );
  }

  Future<void> forgotPassword(String phone) async {
    emit(state.copyWith(status: CustomerAuthStatus.submitting));

    final result = await _forgotPassword(phone);

    result.fold(
      _emitFailure,
      (_) => emit(
        state.copyWith(
          status: CustomerAuthStatus.otpRequested,
          pendingPhone: phone,
        ),
      ),
    );
  }

  Future<void> verifyPasswordOtp(String code) async {
    emit(state.copyWith(status: CustomerAuthStatus.submitting));

    final result = await _verifyPasswordOtp(state.pendingPhone, code);

    result.fold(
      _emitFailure,
      (ticket) => emit(
        state.copyWith(
          status: CustomerAuthStatus.otpVerified,
          resetToken: ticket.resetToken,
        ),
      ),
    );
  }

  Future<void> resetPassword(String newPassword) async {
    emit(state.copyWith(status: CustomerAuthStatus.submitting));

    final result = await _resetPassword(state.resetToken, newPassword);

    result.fold(
      _emitFailure,
      (_) => emit(state.copyWith(status: CustomerAuthStatus.passwordReset)),
    );
  }

  Future<void> logout() async {
    await _logout();
    emit(const CustomerAuthState());
  }

  void _emitFailure(Failure failure) => emit(
    state.copyWith(
      status: CustomerAuthStatus.failure,
      errorMessage: failure.message,
    ),
  );

  void resetStatus() => emit(
    state.copyWith(status: CustomerAuthStatus.initial, errorMessage: null),
  );
}
