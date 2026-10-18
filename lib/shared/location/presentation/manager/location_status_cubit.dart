import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/location_availability.dart';
import '../../domain/use_cases/get_current_location_use_case.dart';
import '../../domain/use_cases/get_location_availability_use_case.dart';
import '../../domain/use_cases/open_location_settings_use_case.dart';
import 'location_status_state.dart';

class LocationStatusCubit extends Cubit<LocationStatusState> {
  final GetLocationAvailabilityUseCase _getAvailability;
  final GetCurrentLocationUseCase _getCurrentLocation;
  final OpenLocationSettingsUseCase _openSettings;

  LocationStatusCubit(
    this._getAvailability,
    this._getCurrentLocation,
    this._openSettings,
  ) : super(const LocationStatusState());

  @override
  void emit(LocationStatusState state) {
    if (isClosed) return;
    super.emit(state);
  }

  Future<void> refresh() async {
    final availability = await _getAvailability();
    emit(LocationStatusState(availability: availability, isLoaded: true));
  }

  Future<void> enable() async {
    final availability = state.availability;
    if (availability == LocationAvailability.permissionDenied) {
      await _getCurrentLocation();
      await refresh();
      return;
    }
    await _openSettings(availability);
  }
}
