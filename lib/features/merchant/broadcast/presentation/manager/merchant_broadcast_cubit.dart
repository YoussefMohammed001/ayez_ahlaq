import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/use_cases/send_merchant_broadcast_use_case.dart';
import 'merchant_broadcast_state.dart';

class MerchantBroadcastCubit extends Cubit<MerchantBroadcastState> {
  final SendMerchantBroadcastUseCase _sendBroadcast;

  MerchantBroadcastCubit(this._sendBroadcast)
    : super(const MerchantBroadcastState());

  void selectScope(MerchantBroadcastScope scope) {
    emit(state.copyWith(scope: scope));
  }

  Future<bool> send({required String title, required String body}) async {
    emit(state.copyWith(status: MerchantBroadcastStatus.sending));

    final scope = state.scope == MerchantBroadcastScope.zone ? 'ZONE' : 'ALL';
    final result = await _sendBroadcast(scope: scope, title: title, body: body);

    return result.fold(
      (failure) {
        emit(
          state.copyWith(
            status: MerchantBroadcastStatus.failure,
            errorMessage: failure.message,
          ),
        );
        return false;
      },
      (_) {
        emit(state.copyWith(status: MerchantBroadcastStatus.success));
        return true;
      },
    );
  }
}
