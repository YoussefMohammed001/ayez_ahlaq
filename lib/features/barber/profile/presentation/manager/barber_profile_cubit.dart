import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/use_cases/change_barber_password_use_case.dart';
import '../../domain/use_cases/get_barber_profile_use_case.dart';
import '../../domain/use_cases/update_barber_location_use_case.dart';
import 'barber_profile_state.dart';

class BarberProfileCubit extends Cubit<BarberProfileState> {
  final GetBarberProfileUseCase _getProfile;
  final UpdateBarberLocationUseCase _updateLocation;
  final ChangeBarberPasswordUseCase _changePassword;

  BarberProfileCubit(this._getProfile, this._updateLocation, this._changePassword)
    : super(const BarberProfileState());

  Future<void> loadProfile() async {
    emit(state.copyWith(status: BarberProfileStatus.loading));

    final result = await _getProfile();

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: BarberProfileStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (profile) => emit(
        state.copyWith(status: BarberProfileStatus.success, profile: profile),
      ),
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
        emit(
          state.copyWith(isSubmitting: false, profile: profile),
        );
        return true;
      },
    );
  }

  Future<bool> changePassword(String currentPassword, String newPassword) async {
    emit(state.copyWith(isSubmitting: true));

    final result = await _changePassword(currentPassword, newPassword);

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
