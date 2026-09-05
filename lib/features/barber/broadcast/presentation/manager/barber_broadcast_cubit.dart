import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/use_cases/send_barber_broadcast_use_case.dart';
import 'barber_broadcast_state.dart';

class BarberBroadcastCubit extends Cubit<BarberBroadcastState> {
  final SendBarberBroadcastUseCase _sendBroadcast;

  BarberBroadcastCubit(this._sendBroadcast)
    : super(const BarberBroadcastState());

  void selectScope(BarberBroadcastScope scope) {
    emit(state.copyWith(scope: scope));
  }

  Future<bool> send({required String title, required String body}) async {
    emit(state.copyWith(status: BarberBroadcastStatus.sending));

    final scope = state.scope == BarberBroadcastScope.mine ? 'MINE' : 'ALL';
    final result = await _sendBroadcast(scope: scope, title: title, body: body);

    return result.fold(
      (failure) {
        emit(
          state.copyWith(
            status: BarberBroadcastStatus.failure,
            errorMessage: failure.message,
          ),
        );
        return false;
      },
      (_) {
        emit(state.copyWith(status: BarberBroadcastStatus.success));
        return true;
      },
    );
  }
}
