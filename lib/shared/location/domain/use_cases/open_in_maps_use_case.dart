import '../entities/geo_point.dart';
import '../repos/i_location_repo.dart';

class OpenInMapsUseCase {
  final ILocationRepo _repo;

  OpenInMapsUseCase(this._repo);

  Future<bool> call(GeoPoint point) => _repo.openInMaps(point);
}
