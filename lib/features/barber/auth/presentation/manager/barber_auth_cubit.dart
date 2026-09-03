import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/use_cases/barber_login_use_case.dart';
import '../../domain/use_cases/barber_logout_use_case.dart';
import 'barber_auth_state.dart';

class BarberAuthCubit extends Cubit<BarberAuthState> {
  final BarberLoginUseCase _login;
  final BarberLogoutUseCase _logout;

  BarberAuthCubit(this._login, this._logout) : super(const BarberAuthState());

  Future<void> login(String identifier, String password) async {
    emit(state.copyWith(status: BarberAuthStatus.submitting));

    final result = await _login(identifier, password);

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: BarberAuthStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (_) => emit(state.copyWith(status: BarberAuthStatus.authenticated)),
    );
  }

  Future<void> logout() async {
    await _logout();
    emit(const BarberAuthState());
  }
}
