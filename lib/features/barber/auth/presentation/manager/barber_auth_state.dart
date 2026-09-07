import 'package:equatable/equatable.dart';

enum BarberAuthStatus {
  initial,
  submitting,
  authenticated,
  otpRequested,
  otpResent,
  otpVerified,
  passwordReset,
  failure,
}

class BarberAuthState extends Equatable {
  final BarberAuthStatus status;
  final String? errorMessage;
  final String? infoMessage;
  final String pendingPhone;
  final String resetToken;

  const BarberAuthState({
    this.status = BarberAuthStatus.initial,
    this.errorMessage,
    this.infoMessage,
    this.pendingPhone = '',
    this.resetToken = '',
  });

  BarberAuthState copyWith({
    BarberAuthStatus? status,
    String? errorMessage,
    String? infoMessage,
    String? pendingPhone,
    String? resetToken,
  }) {
    return BarberAuthState(
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
