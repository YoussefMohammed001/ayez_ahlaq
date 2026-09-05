import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/requests/customer_register_request.dart';
import '../../domain/use_cases/customer_login_use_case.dart';
import '../../domain/use_cases/customer_logout_use_case.dart';
import '../../domain/use_cases/customer_register_use_case.dart';
import 'customer_auth_state.dart';

class CustomerAuthCubit extends Cubit<CustomerAuthState> {
  final CustomerLoginUseCase _login;
  final CustomerRegisterUseCase _register;
  final CustomerLogoutUseCase _logout;

  CustomerAuthCubit(this._login, this._register, this._logout)
    : super(const CustomerAuthState());

  Future<void> login(String identifier, String password) async {
    emit(state.copyWith(status: CustomerAuthStatus.submitting));

    final result = await _login(identifier, password);

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: CustomerAuthStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (_) => emit(state.copyWith(status: CustomerAuthStatus.authenticated)),
    );
  }

  Future<void> register(CustomerRegisterRequest request) async {
    emit(state.copyWith(status: CustomerAuthStatus.submitting));

    final result = await _register(request);

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: CustomerAuthStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (_) => emit(state.copyWith(status: CustomerAuthStatus.authenticated)),
    );
  }

  Future<void> logout() async {
    await _logout();
    emit(const CustomerAuthState());
  }
}
