import '../entities/device_location_result.dart';
import '../repos/i_location_repo.dart';

class GetCurrentLocationUseCase {
  final ILocationRepo _repo;

  GetCurrentLocationUseCase(this._repo);

  Future<DeviceLocationResult> call({bool requestPermission = true}) =>
      _repo.currentLocation(requestPermission: requestPermission);
}
