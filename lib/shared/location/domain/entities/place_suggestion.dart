import 'package:equatable/equatable.dart';
import 'geo_point.dart';
import 'place_info.dart';

class PlaceSuggestion extends Equatable {
  final GeoPoint point;
  final PlaceInfo info;

  const PlaceSuggestion({required this.point, required this.info});

  @override
  List<Object?> get props => [point, info];
}
