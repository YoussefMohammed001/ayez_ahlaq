import 'package:equatable/equatable.dart';
import '../../domain/entities/geo_point.dart';
import '../../domain/entities/place_info.dart';

class MapLocationPickerState extends Equatable {
  final GeoPoint target;
  final PlaceInfo place;
  final bool isResolvingPlace;
  final bool isLocating;
  final bool isSearching;
  final String? errorMessage;

  const MapLocationPickerState({
    required this.target,
    this.place = PlaceInfo.empty,
    this.isResolvingPlace = false,
    this.isLocating = false,
    this.isSearching = false,
    this.errorMessage,
  });

  MapLocationPickerState copyWith({
    GeoPoint? target,
    PlaceInfo? place,
    bool? isResolvingPlace,
    bool? isLocating,
    bool? isSearching,
    String? errorMessage,
  }) {
    return MapLocationPickerState(
      target: target ?? this.target,
      place: place ?? this.place,
      isResolvingPlace: isResolvingPlace ?? this.isResolvingPlace,
      isLocating: isLocating ?? this.isLocating,
      isSearching: isSearching ?? this.isSearching,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    target,
    place,
    isResolvingPlace,
    isLocating,
    isSearching,
    errorMessage,
  ];
}
