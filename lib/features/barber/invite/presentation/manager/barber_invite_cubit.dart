import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/use_cases/get_barber_invite_use_case.dart';
import '../../domain/use_cases/regenerate_barber_invite_use_case.dart';
import 'barber_invite_state.dart';

class BarberInviteCubit extends Cubit<BarberInviteState> {
  final GetBarberInviteUseCase _getInvite;
  final RegenerateBarberInviteUseCase _regenerateInvite;

  BarberInviteCubit(this._getInvite, this._regenerateInvite)
    : super(const BarberInviteState());

  Future<void> loadInvite() async {
    emit(state.copyWith(status: BarberInviteStatus.loading));

    final result = await _getInvite();

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: BarberInviteStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (invite) =>
          emit(state.copyWith(status: BarberInviteStatus.success, invite: invite)),
    );
  }

  Future<bool> regenerate() async {
    emit(state.copyWith(isRegenerating: true));

    final result = await _regenerateInvite();

    return result.fold(
      (failure) {
        emit(
          state.copyWith(isRegenerating: false, errorMessage: failure.message),
        );
        return false;
      },
      (invite) {
        emit(
          state.copyWith(
            isRegenerating: false,
            status: BarberInviteStatus.success,
            invite: invite,
          ),
        );
        return true;
      },
    );
  }
}
