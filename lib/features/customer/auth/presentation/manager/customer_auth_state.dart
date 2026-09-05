import 'package:equatable/equatable.dart';

enum CustomerAuthStatus { initial, submitting, authenticated, failure }

class CustomerAuthState extends Equatable {
  final CustomerAuthStatus status;
  final String? errorMessage;

  const CustomerAuthState({
    this.status = CustomerAuthStatus.initial,
    this.errorMessage,
  });

  CustomerAuthState copyWith({
    CustomerAuthStatus? status,
    String? errorMessage,
  }) {
    return CustomerAuthState(
      status: status ?? this.status,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, errorMessage];
}
