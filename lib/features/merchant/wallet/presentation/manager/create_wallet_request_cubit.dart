import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/wallet_request_type.dart';
import '../../domain/use_cases/create_wallet_request_use_case.dart';
import 'create_wallet_request_state.dart';

class CreateWalletRequestCubit extends Cubit<CreateWalletRequestState> {
  final CreateWalletRequestUseCase _createWalletRequest;

  CreateWalletRequestCubit(this._createWalletRequest)
    : super(const CreateWalletRequestState());

  Future<bool> submit({
    required WalletRequestType type,
    required int amount,
    String? note,
    String? filePath,
  }) async {
    emit(state.copyWith(status: CreateWalletRequestStatus.submitting));

    final result = await _createWalletRequest(
      type: type,
      amount: amount,
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
