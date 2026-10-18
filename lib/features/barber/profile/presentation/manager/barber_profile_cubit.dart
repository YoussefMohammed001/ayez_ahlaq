import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/use_cases/change_barber_password_use_case.dart';
import '../../domain/use_cases/delete_barber_account_use_case.dart';
import '../../domain/use_cases/delete_barber_profile_image_use_case.dart';
import '../../domain/use_cases/get_barber_profile_image_use_case.dart';
import '../../domain/use_cases/get_barber_profile_use_case.dart';
import '../../domain/use_cases/get_cached_barber_profile_image_use_case.dart';
import '../../domain/use_cases/update_barber_location_use_case.dart';
import '../../domain/use_cases/update_serves_clients_use_case.dart';
import '../../domain/use_cases/upload_barber_profile_image_use_case.dart';
import 'barber_profile_state.dart';

class BarberProfileCubit extends Cubit<BarberProfileState> {
  final GetBarberProfileUseCase _getProfile;
  final UpdateBarberLocationUseCase _updateLocation;
  final UpdateServesClientsUseCase _updateServesClients;
  final ChangeBarberPasswordUseCase _changePassword;
  final DeleteBarberAccountUseCase _deleteAccount;
  final UploadBarberProfileImageUseCase _uploadProfileImage;
  final GetBarberProfileImageUseCase _getProfileImage;
  final GetCachedBarberProfileImageUseCase _getCachedProfileImage;
  final DeleteBarberProfileImageUseCase _deleteProfileImage;

  bool _imageLoadRequested = false;

  BarberProfileCubit(
    this._getProfile,
    this._updateLocation,
    this._updateServesClients,
    this._changePassword,
    this._deleteAccount,
    this._uploadProfileImage,
    this._getProfileImage,
    this._getCachedProfileImage,
    this._deleteProfileImage,
  ) : super(const BarberProfileState());

  void reset() {
    _imageLoadRequested = false;
    emit(const BarberProfileState());
  }

  Future<void> loadProfile({bool force = false}) async {
    if (!force && state.status == BarberProfileStatus.success) return;

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
        emit(state.copyWith(isSubmitting: false, profile: profile));
        return true;
      },
    );
  }

  Future<bool> updateServesClients(bool value) async {
    emit(state.copyWith(isSubmitting: true));

    final result = await _updateServesClients(value);

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

  Future<bool> changePassword(
    String currentPassword,
    String newPassword,
  ) async {
    emit(state.copyWith(isSubmitting: true));

    final result = await _changePassword(currentPassword, newPassword);

    final failure = result.fold((value) => value, (_) => null);

    if (failure != null) {
      emit(state.copyWith(isSubmitting: false, errorMessage: failure.message));
      return false;
    }

    emit(state.copyWith(isSubmitting: false));
    await loadProfile(force: true);
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

  Future<void> loadProfileImage({bool force = false}) async {
    if (_imageLoadRequested && !force) return;
    _imageLoadRequested = true;

    final cached = await _getCachedProfileImage();
    if (cached != null) {
      emit(
        state.copyWith(
          imageStatus: ProfileImageStatus.loaded,
          profileImageBytes: cached,
        ),
      );
    } else {
      emit(state.copyWith(imageStatus: ProfileImageStatus.loading));
    }

    final result = await _getProfileImage();

    result.fold((_) => emit(state.clearProfileImage()), (bytes) {
      emit(
        state.copyWith(
          imageStatus: ProfileImageStatus.loaded,
          profileImageBytes: bytes,
        ),
      );
    });
  }

  Future<bool> uploadProfileImage(String filePath) async {
    final statusBeforeSubmit = state.imageStatus;
    emit(state.copyWith(imageStatus: ProfileImageStatus.submitting));

    final result = await _uploadProfileImage(filePath);

    return result.fold(
      (failure) {
        emit(
          state.copyWith(
            imageStatus: statusBeforeSubmit,
            errorMessage: failure.message,
          ),
        );
        return false;
      },
      (_) async {
        await loadProfileImage(force: true);
        return true;
      },
    );
  }

  Future<bool> deleteProfileImage() async {
    emit(state.copyWith(imageStatus: ProfileImageStatus.submitting));

    final result = await _deleteProfileImage();

    return result.fold(
      (failure) {
        emit(
          state.copyWith(
            imageStatus: ProfileImageStatus.loaded,
            errorMessage: failure.message,
          ),
        );
        return false;
      },
      (_) {
        emit(state.clearProfileImage());
        return true;
      },
    );
  }
}
