import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/barber_profile.dart';
import '../repos/i_barber_profile_repo.dart';

class UpdateBarberLocationUseCase {
  final IBarberProfileRepo _repo;

  UpdateBarberLocationUseCase(this._repo);

  Future<Either<Failure, BarberProfile>> call({
    double? latitude,
    double? longitude,
    String? address,
  }) => _repo.updateLocation(
    latitude: latitude,
    longitude: longitude,
    address: address,
  );
}
