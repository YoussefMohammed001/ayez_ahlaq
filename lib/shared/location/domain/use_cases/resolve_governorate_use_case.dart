import '../entities/geo_point.dart';
import '../repos/i_location_repo.dart';

class ResolveGovernorateUseCase {
  final ILocationRepo _repo;

  ResolveGovernorateUseCase(this._repo);

  Future<String?> call(GeoPoint point) => _repo.governorateOf(point);
}
