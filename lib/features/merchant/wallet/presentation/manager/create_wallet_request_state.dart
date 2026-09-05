import 'package:equatable/equatable.dart';
import '../../domain/entities/wallet_request.dart';

enum CreateWalletRequestStatus { initial, submitting, success, failure }

class CreateWalletRequestState extends Equatable {
  final CreateWalletRequestStatus status;
  final WalletRequest? created;
  final String? errorMessage;

  const CreateWalletRequestState({
    this.status = CreateWalletRequestStatus.initial,
    this.created,
    this.errorMessage,
  });

  CreateWalletRequestState copyWith({
    CreateWalletRequestStatus? status,
    WalletRequest? created,
    String? errorMessage,
  }) {
    return CreateWalletRequestState(
      status: status ?? this.status,
      created: created ?? this.created,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, created, errorMessage];
}
