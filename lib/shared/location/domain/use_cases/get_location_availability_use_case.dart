import '../entities/location_availability.dart';
import '../repos/i_location_repo.dart';

class GetLocationAvailabilityUseCase {
  final ILocationRepo _repo;

  GetLocationAvailabilityUseCase(this._repo);

  Future<LocationAvailability> call() => _repo.availability();
}
