import 'package:equatable/equatable.dart';
import '../../domain/entities/transfer_account.dart';
import '../../domain/entities/wallet_request.dart';

enum CreateWalletRequestStatus { initial, submitting, success, failure }

enum TransferAccountsStatus { initial, loading, success, failure }

class CreateWalletRequestState extends Equatable {
  final CreateWalletRequestStatus status;
  final WalletRequest? created;
  final String? errorMessage;
  final TransferAccountsStatus transferAccountsStatus;
  final List<TransferAccount> transferAccounts;

  const CreateWalletRequestState({
    this.status = CreateWalletRequestStatus.initial,
    this.created,
    this.errorMessage,
    this.transferAccountsStatus = TransferAccountsStatus.initial,
    this.transferAccounts = const [],
  });

  CreateWalletRequestState copyWith({
    CreateWalletRequestStatus? status,
    WalletRequest? created,
    String? errorMessage,
    TransferAccountsStatus? transferAccountsStatus,
    List<TransferAccount>? transferAccounts,
  }) {
    return CreateWalletRequestState(
      status: status ?? this.status,
      created: created ?? this.created,
      errorMessage: errorMessage,
      transferAccountsStatus: transferAccountsStatus ?? this.transferAccountsStatus,
      transferAccounts: transferAccounts ?? this.transferAccounts,
    );
  }

  @override
  List<Object?> get props => [
    status,
    created,
    errorMessage,
    transferAccountsStatus,
    transferAccounts,
  ];
}
