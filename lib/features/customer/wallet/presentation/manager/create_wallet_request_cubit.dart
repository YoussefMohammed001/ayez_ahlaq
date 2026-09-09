import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/wallet_request_type.dart';
import '../../domain/use_cases/create_wallet_request_use_case.dart';
import '../../domain/use_cases/get_transfer_accounts_use_case.dart';
import 'create_wallet_request_state.dart';

class CreateWalletRequestCubit extends Cubit<CreateWalletRequestState> {
  final CreateWalletRequestUseCase _createWalletRequest;
  final GetTransferAccountsUseCase _getTransferAccounts;

  CreateWalletRequestCubit(this._createWalletRequest, this._getTransferAccounts)
    : super(const CreateWalletRequestState());

  Future<void> loadTransferAccounts() async {
    emit(state.copyWith(transferAccountsStatus: TransferAccountsStatus.loading));

    final result = await _getTransferAccounts();

    result.fold(
      (failure) => emit(
        state.copyWith(
          transferAccountsStatus: TransferAccountsStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (accounts) => emit(
        state.copyWith(
          transferAccountsStatus: TransferAccountsStatus.success,
          transferAccounts: accounts,
        ),
      ),
    );
  }

  Future<bool> submit({
    required WalletRequestType type,
    required int amount,
    int? transferAccountId,
    String? note,
    String? filePath,
  }) async {
    emit(state.copyWith(status: CreateWalletRequestStatus.submitting));

    final result = await _createWalletRequest(
      type: type,
      amount: amount,
      transferAccountId: transferAccountId,
      note: note,
      filePath: filePath,
    );

    return result.fold(
      (failure) {
        emit(
          state.copyWith(
            status: CreateWalletRequestStatus.failure,
            errorMessage: failure.message,
          ),
        );
        return false;
      },
      (created) {
        emit(
          state.copyWith(
            status: CreateWalletRequestStatus.success,
            created: created,
          ),
        );
        return true;
      },
    );
  }
}
