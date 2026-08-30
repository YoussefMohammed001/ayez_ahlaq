import 'package:equatable/equatable.dart';

enum AuthStatus { initial, submitting, authenticated, failure }

class MerchantAuthState extends Equatable {
  final AuthStatus status;
  final String? errorMessage;

  const MerchantAuthState({
    this.status = AuthStatus.initial,
    this.errorMessage,
  });

  MerchantAuthState copyWith({AuthStatus? status, String? errorMessage}) {
    return MerchantAuthState(
      status: status ?? this.status,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, errorMessage];
}
