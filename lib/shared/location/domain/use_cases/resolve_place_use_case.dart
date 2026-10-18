import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entities/geo_point.dart';
import '../entities/place_info.dart';
import '../repos/i_location_repo.dart';

class ResolvePlaceUseCase {
  final ILocationRepo _repo;

  ResolvePlaceUseCase(this._repo);

  Future<Either<Failure, PlaceInfo>> call(GeoPoint point) =>
      _repo.placeOf(point);
}
