import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../shared/auth/data/local/auth_local_data_source.dart';
import '../../domain/entities/barber_profile.dart';
import '../../domain/repos/i_barber_profile_repo.dart';
import '../apis/barber_profile_api.dart';
import '../models/barber_profile_model.dart';

class BarberProfileRepo implements IBarberProfileRepo {
  final BarberProfileApi _api;
  final AuthLocalDataSource _localDataSource;

  BarberProfileRepo(this._api, this._localDataSource);

  @override
  Future<Either<Failure, BarberProfile>> getProfile() async {
    final result = await _api.getProfile();
    return result.map(_mapProfile);
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
    return result.map(_mapProfile);
  }

  @override
  Future<Either<Failure, BarberProfile>> updateServesClients(bool value) async {
    final result = await _api.updateServesClients(value);
    return result.map(_mapProfile);
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

  BarberProfile _mapProfile(dynamic response) {
    return BarberProfileModel.fromJson(
      response['data'] as Map<String, dynamic>,
    );
  }
}
