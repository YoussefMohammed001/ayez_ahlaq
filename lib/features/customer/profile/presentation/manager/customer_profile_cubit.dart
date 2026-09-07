import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/error/failure.dart';
import '../../domain/use_cases/change_customer_password_use_case.dart';
import '../../domain/use_cases/delete_customer_account_use_case.dart';
import '../../domain/use_cases/get_customer_profile_use_case.dart';
import 'customer_profile_state.dart';

class CustomerProfileCubit extends Cubit<CustomerProfileState> {
  final GetCustomerProfileUseCase _getProfile;
  final ChangeCustomerPasswordUseCase _changePassword;
  final DeleteCustomerAccountUseCase _deleteAccount;

  CustomerProfileCubit(
    this._getProfile,
    this._changePassword,
    this._deleteAccount,
  ) : super(const CustomerProfileState());

  Future<void> loadProfile() async {
    emit(state.copyWith(status: CustomerProfileStatus.loading));

    final result = await _getProfile();

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: CustomerProfileStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (profile) => emit(
        state.copyWith(status: CustomerProfileStatus.success, profile: profile),
      ),
    );
  }

  Future<bool> changePassword(
    String currentPassword,
    String newPassword,
  ) async {
    emit(state.copyWith(isSubmitting: true));

    final result = await _changePassword(currentPassword, newPassword);

    return _settle(result);
  }

  Future<bool> deleteAccount(String password) async {
    emit(state.copyWith(isSubmitting: true));

    final result = await _deleteAccount(password);

    return _settle(result);
  }

  bool _settle(Either<Failure, Unit> result) {
    return result.fold(
      (failure) {
        emit(
          state.copyWith(isSubmitting: false, errorMessage: failure.message),
        );
        return false;
      },
      (_) {
        emit(state.copyWith(isSubmitting: false));
        return true;
      },
    );
  }
}
