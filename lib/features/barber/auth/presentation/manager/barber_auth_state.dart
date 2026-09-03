import 'package:equatable/equatable.dart';

enum BarberAuthStatus { initial, submitting, authenticated, failure }

class BarberAuthState extends Equatable {
  final BarberAuthStatus status;
  final String? errorMessage;

  const BarberAuthState({
    this.status = BarberAuthStatus.initial,
    this.errorMessage,
  });

  BarberAuthState copyWith({BarberAuthStatus? status, String? errorMessage}) {
    return BarberAuthState(
      status: status ?? this.status,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, errorMessage];
}
