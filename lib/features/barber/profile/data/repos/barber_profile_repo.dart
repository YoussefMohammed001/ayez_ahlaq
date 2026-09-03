import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../domain/entities/barber_profile.dart';
import '../../domain/repos/i_barber_profile_repo.dart';
import '../apis/barber_profile_api.dart';
import '../models/barber_profile_model.dart';

class BarberProfileRepo implements IBarberProfileRepo {
  final BarberProfileApi _api;

  BarberProfileRepo(this._api);

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
  Future<Either<Failure, Unit>> changePassword(
    String currentPassword,
    String newPassword,
  ) async {
    final result = await _api.changePassword(currentPassword, newPassword);
    return result.map((_) => unit);
  }

  BarberProfile _mapProfile(dynamic response) {
    return BarberProfileModel.fromJson(response['data'] as Map<String, dynamic>);
  }
}
