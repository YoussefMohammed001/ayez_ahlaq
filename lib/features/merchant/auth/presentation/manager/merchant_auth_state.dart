import 'package:equatable/equatable.dart';

enum AuthStatus {
  initial,
  submitting,
  authenticated,
  otpRequested,
  otpResent,
  otpVerified,
  passwordReset,
  failure,
}

class MerchantAuthState extends Equatable {
  final AuthStatus status;
  final String? errorMessage;
  final String? infoMessage;
  final String pendingPhone;
  final String resetToken;

  const MerchantAuthState({
    this.status = AuthStatus.initial,
    this.errorMessage,
    this.infoMessage,
    this.pendingPhone = '',
    this.resetToken = '',
  });

  MerchantAuthState copyWith({
    AuthStatus? status,
    String? errorMessage,
    String? infoMessage,
    String? pendingPhone,
    String? resetToken,
  }) {
    return MerchantAuthState(
      status: status ?? this.status,
      errorMessage: errorMessage,
      infoMessage: infoMessage,
      pendingPhone: pendingPhone ?? this.pendingPhone,
      resetToken: resetToken ?? this.resetToken,
    );
  }

  @override
  List<Object?> get props => [
    status,
    errorMessage,
    infoMessage,
    pendingPhone,
    resetToken,
  ];
}
