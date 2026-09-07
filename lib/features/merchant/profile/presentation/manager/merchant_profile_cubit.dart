import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/use_cases/change_password_use_case.dart';
import '../../domain/use_cases/delete_merchant_account_use_case.dart';
import '../../domain/use_cases/get_merchant_profile_use_case.dart';
import '../../domain/use_cases/update_merchant_location_use_case.dart';
import '../../domain/use_cases/update_merchant_profile_use_case.dart';
import 'merchant_profile_state.dart';

class MerchantProfileCubit extends Cubit<MerchantProfileState> {
  final GetMerchantProfileUseCase _getProfile;
  final UpdateMerchantProfileUseCase _updateProfile;
  final UpdateMerchantLocationUseCase _updateLocation;
  final ChangePasswordUseCase _changePassword;
  final DeleteMerchantAccountUseCase _deleteAccount;

  MerchantProfileCubit(
    this._getProfile,
    this._updateProfile,
    this._updateLocation,
    this._changePassword,
    this._deleteAccount,
  ) : super(const MerchantProfileState());

  Future<void> loadProfile() async {
    emit(state.copyWith(status: ProfileStatus.loading));

    final result = await _getProfile();

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: ProfileStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (profile) =>
          emit(state.copyWith(status: ProfileStatus.success, profile: profile)),
    );
  }

  Future<bool> updateProfile({
    required String businessName,
    required String ownerName,
    String? email,
  }) async {
    emit(state.copyWith(isSubmitting: true));

    final result = await _updateProfile(
      businessName: businessName,
      ownerName: ownerName,
      email: email,
    );

    return result.fold(
      (failure) {
        emit(
          state.copyWith(isSubmitting: false, errorMessage: failure.message),
        );
        return false;
      },
      (profile) {
        emit(state.copyWith(isSubmitting: false, profile: profile));
        return true;
      },
    );
  }

  Future<bool> updateLocation({
    double? latitude,
    double? longitude,
    String? address,
  }) async {
    emit(state.copyWith(isSubmitting: true));

    final result = await _updateLocation(
      latitude: latitude,
      longitude: longitude,
      address: address,
    );

    return result.fold(
      (failure) {
        emit(
          state.copyWith(isSubmitting: false, errorMessage: failure.message),
        );
        return false;
      },
      (profile) {
        emit(state.copyWith(isSubmitting: false, profile: profile));
        return true;
      },
    );
  }

  Future<bool> changePassword(String current, String next) async {
    emit(state.copyWith(isSubmitting: true));

    final result = await _changePassword(current, next);

    final failure = result.fold((value) => value, (_) => null);

    if (failure != null) {
      emit(state.copyWith(isSubmitting: false, errorMessage: failure.message));
      return false;
    }

    emit(state.copyWith(isSubmitting: false));
    await loadProfile();
    return true;
  }

  Future<bool> deleteAccount(String password) async {
    emit(state.copyWith(isSubmitting: true));

    final result = await _deleteAccount(password);

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
