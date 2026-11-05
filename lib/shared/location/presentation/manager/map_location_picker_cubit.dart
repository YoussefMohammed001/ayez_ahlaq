import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../generated/l10n.dart';
import '../../domain/entities/geo_point.dart';
import '../../domain/entities/location_availability.dart';
import '../../domain/entities/picked_location.dart';
import '../../domain/entities/place_info.dart';
import '../../domain/use_cases/get_current_location_use_case.dart';
import '../../domain/use_cases/resolve_place_use_case.dart';
import '../../domain/use_cases/search_places_use_case.dart';
import 'map_location_picker_state.dart';

class MapLocationPickerCubit extends Cubit<MapLocationPickerState> {
  static const defaultTarget = GeoPoint(30.0444, 31.2357);

  final GetCurrentLocationUseCase _getCurrentLocation;
  final ResolvePlaceUseCase _resolvePlace;
  final SearchPlacesUseCase _searchPlaces;
  int _placeRequestId = 0;
  int _searchRequestId = 0;
  bool _hasInitialLocation = false;

  MapLocationPickerCubit(
    this._getCurrentLocation,
    this._resolvePlace,
    this._searchPlaces,
  ) : super(const MapLocationPickerState(target: defaultTarget));

  @override
  void emit(MapLocationPickerState state) {
    if (isClosed) return;
    super.emit(state);
  }

  bool get hasInitialLocation => _hasInitialLocation;

  bool get canConfirm =>
      !state.isMoving &&
      !state.isResolvingPlace &&
      !state.isSearching &&
      !state.isLocating;

  void start(PickedLocation? initial) {
    if (initial == null) return;
    _hasInitialLocation = true;
    emit(
      state.copyWith(
        target: GeoPoint(initial.latitude, initial.longitude),
        place: PlaceInfo(
          name: initial.name,
          city: initial.city,
          fullAddress: initial.address,
        ),
      ),
    );
  }

  void onCameraMove() {
    if (state.isMoving) return;
    _placeRequestId++;
    emit(state.copyWith(isMoving: true, isResolvingPlace: false));
  }

  Future<void> onCameraIdle(GeoPoint target) async {
    final requestId = ++_placeRequestId;
    emit(
      state.copyWith(target: target, isMoving: false, isResolvingPlace: true),
    );

    final result = await _resolvePlace(target);
    if (requestId != _placeRequestId) return;

    emit(
      state.copyWith(
        place: result.getOrElse(() => PlaceInfo.empty),
        isResolvingPlace: false,
      ),
    );
  }

  Future<GeoPoint?> locateMe({bool silent = false}) async {
    emit(state.copyWith(isLocating: true));

    final result = await _getCurrentLocation();
    emit(
      state.copyWith(
        isLocating: false,
        errorMessage: result.hasPoint || silent
            ? null
            : _messageOf(result.availability),
      ),
    );
    return result.point;
  }

  Future<GeoPoint?> searchAndSelect(String query) async {
    final trimmed = query.trim();
    if (trimmed.isEmpty) return null;

    final requestId = ++_searchRequestId;
    emit(state.copyWith(isSearching: true));
    final result = await _searchPlaces(trimmed);
    if (requestId != _searchRequestId) return null;

    final suggestions = result.getOrElse(() => const []);
    if (suggestions.isEmpty) {
      emit(state.copyWith(isSearching: false, errorMessage: S().noPlacesFound));
      return null;
    }

    final found = suggestions.first;
    emit(
      state.copyWith(
        isSearching: false,
        target: found.point,
        place: found.info,
      ),
    );
    return found.point;
  }

  PickedLocation get picked => PickedLocation(
    latitude: state.target.latitude,
    longitude: state.target.longitude,
    address: state.place.fullAddress,
    name: state.place.name,
    city: state.place.city,
  );

  String _messageOf(LocationAvailability availability) {
    switch (availability) {
      case LocationAvailability.serviceDisabled:
        return S().locationServiceDisabled;
      case LocationAvailability.permissionDenied:
      case LocationAvailability.permissionDeniedForever:
        return S().locationPermissionDenied;
      default:
        return S().locationUnavailableMessage;
    }
  }
}
