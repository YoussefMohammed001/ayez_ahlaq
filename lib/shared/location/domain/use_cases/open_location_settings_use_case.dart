import '../entities/location_availability.dart';
import '../repos/i_location_repo.dart';

class OpenLocationSettingsUseCase {
  final ILocationRepo _repo;

  OpenLocationSettingsUseCase(this._repo);

  Future<void> call(LocationAvailability availability) =>
      _repo.openSettings(availability);
}
