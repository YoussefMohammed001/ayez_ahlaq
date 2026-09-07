import 'package:equatable/equatable.dart';

enum CustomerAuthStatus {
  initial,
  submitting,
  authenticated,
  otpRequested,
  otpResent,
  otpVerified,
  passwordReset,
  failure,
}

class CustomerAuthState extends Equatable {
  final CustomerAuthStatus status;
  final String? errorMessage;
  final String? infoMessage;
  final String pendingPhone;
  final String resetToken;

  const CustomerAuthState({
    this.status = CustomerAuthStatus.initial,
    this.errorMessage,
    this.infoMessage,
    this.pendingPhone = '',
    this.resetToken = '',
  });

  CustomerAuthState copyWith({
    CustomerAuthStatus? status,
    String? errorMessage,
    String? infoMessage,
    String? pendingPhone,
    String? resetToken,
  }) {
    return CustomerAuthState(
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
