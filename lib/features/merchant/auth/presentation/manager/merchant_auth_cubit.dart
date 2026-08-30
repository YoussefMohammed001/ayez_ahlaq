import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/requests/register_request.dart';
import '../../domain/use_cases/merchant_login_use_case.dart';
import '../../domain/use_cases/merchant_logout_use_case.dart';
import '../../domain/use_cases/merchant_register_use_case.dart';
import 'merchant_auth_state.dart';

class MerchantAuthCubit extends Cubit<MerchantAuthState> {
  final MerchantLoginUseCase _login;
  final MerchantRegisterUseCase _register;
  final MerchantLogoutUseCase _logout;

  MerchantAuthCubit(this._login, this._register, this._logout)
    : super(const MerchantAuthState());

  Future<void> login(String phone, String password) async {
    emit(state.copyWith(status: AuthStatus.submitting));

    final result = await _login(phone, password);

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: AuthStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (_) => emit(state.copyWith(status: AuthStatus.authenticated)),
    );
  }

  Future<void> register(RegisterRequest request) async {
    emit(state.copyWith(status: AuthStatus.submitting));

    final result = await _register(request);

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: AuthStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (_) => emit(state.copyWith(status: AuthStatus.authenticated)),
    );
  }

  Future<void> logout() async {
    await _logout();
    emit(const MerchantAuthState());
  }
}
