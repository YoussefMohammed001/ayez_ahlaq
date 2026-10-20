import 'package:equatable/equatable.dart';
import '../../domain/entities/transfer_account.dart';
import '../../domain/entities/wallet_request.dart';
import '../../domain/entities/withdraw_method.dart';

enum CreateWalletRequestStatus { initial, submitting, success, failure }

enum TransferAccountsStatus { initial, loading, success, failure }

class CreateWalletRequestState extends Equatable {
  final CreateWalletRequestStatus status;
  final WalletRequest? created;
  final String? errorMessage;
  final TransferAccountsStatus transferAccountsStatus;
  final List<TransferAccount> transferAccounts;
  final List<WithdrawMethod> withdrawMethods;

  const CreateWalletRequestState({
    this.status = CreateWalletRequestStatus.initial,
    this.created,
    this.errorMessage,
    this.transferAccountsStatus = TransferAccountsStatus.initial,
    this.transferAccounts = const [],
    this.withdrawMethods = const [],
  });

  CreateWalletRequestState copyWith({
    CreateWalletRequestStatus? status,
    WalletRequest? created,
    String? errorMessage,
    TransferAccountsStatus? transferAccountsStatus,
    List<TransferAccount>? transferAccounts,
    List<WithdrawMethod>? withdrawMethods,
  }) {
    return CreateWalletRequestState(
      status: status ?? this.status,
      created: created ?? this.created,
      errorMessage: errorMessage,
      transferAccountsStatus: transferAccountsStatus ?? this.transferAccountsStatus,
      transferAccounts: transferAccounts ?? this.transferAccounts,
      withdrawMethods: withdrawMethods ?? this.withdrawMethods,
    );
  }

  @override
  List<Object?> get props => [
    status,
    created,
    errorMessage,
    transferAccountsStatus,
    transferAccounts,
    withdrawMethods,
  ];
}
