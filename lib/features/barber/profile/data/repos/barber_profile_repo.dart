import 'dart:typed_data';
import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/network/response_guard.dart';
import '../../../../../shared/auth/data/local/auth_local_data_source.dart';
import '../../domain/entities/barber_profile.dart';
import '../../domain/repos/i_barber_profile_repo.dart';
import '../apis/barber_profile_api.dart';
import '../local/barber_profile_image_cache.dart';
import '../models/barber_profile_model.dart';

class BarberProfileRepo implements IBarberProfileRepo {
  final BarberProfileApi _api;
  final AuthLocalDataSource _localDataSource;
  final BarberProfileImageCache _imageCache;

  BarberProfileRepo(this._api, this._localDataSource, this._imageCache);

  @override
  Future<Either<Failure, BarberProfile>> getProfile() async {
    final result = await _api.getProfile();
    return result.flatMap(_mapProfile);
  }

  @override
  Future<Either<Failure, BarberProfile>> updateLocation({
    double? latitude,
    double? longitude,
    String? address,
  }) async {
    final result = await _api.updateLocation({
      'latitude': latitude,
      'longitude': longitude,
      'address': address,
    });
    return result.flatMap(_mapProfile);
  }

  @override
  Future<Either<Failure, BarberProfile>> updateServesClients(bool value) async {
    final result = await _api.updateServesClients(value);
    return result.flatMap(_mapProfile);
  }

  @override
  Future<Either<Failure, Unit>> changePassword(
    String currentPassword,
    String newPassword,
  ) async {
    final result = await _api.changePassword(currentPassword, newPassword);
    return result.map((_) => unit);
  }

  @override
  Future<Either<Failure, Unit>> deleteAccount(String password) async {
    final result = await _api.deleteAccount(password);

    await result.fold((_) async {}, (_) => _localDataSource.clearSession());

    return result.map((_) => unit);
  }

  @override
  Future<Either<Failure, Unit>> uploadProfileImage(String filePath) async {
    final result = await _api.uploadProfileImage(filePath);
    return result.map((_) => unit);
  }

  @override
  Future<Uint8List?> getCachedProfileImage() => _imageCache.read();

  @override
  Future<Either<Failure, Uint8List>> getProfileImage() async {
    final result = await _api.getProfileImage();
    final bytes = result.map(
      (data) => Uint8List.fromList(data as List<int>),
    );

    await bytes.fold((_) async {}, _imageCache.write);

    return bytes;
  }

  @override
  Future<Either<Failure, Unit>> deleteProfileImage() async {
    final result = await _api.deleteProfileImage();
    await result.fold((_) async {}, (_) => _imageCache.clear());
    return result.map((_) => unit);
  }

  Either<Failure, BarberProfile> _mapProfile(dynamic response) {
    return requireDataMap(response).map(BarberProfileModel.fromJson);
  }
}
