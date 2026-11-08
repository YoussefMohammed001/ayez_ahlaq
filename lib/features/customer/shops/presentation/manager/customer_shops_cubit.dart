import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/analytics/app_analytics.dart';
import '../../../../../shared/location/domain/entities/geo_point.dart';
import '../../../../../shared/location/domain/entities/picked_location.dart';
import '../../../../../shared/location/domain/use_cases/get_current_location_use_case.dart';
import '../../domain/entities/shops_area.dart';
import '../../domain/use_cases/get_shops_use_case.dart';
import 'customer_shops_state.dart';

class CustomerShopsCubit extends Cubit<CustomerShopsState> {
  final GetShopsUseCase _getShops;
  final GetCurrentLocationUseCase _getCurrentLocation;
  final AppAnalytics _analytics;

  CustomerShopsCubit(this._getShops, this._getCurrentLocation, this._analytics)
    : super(const CustomerShopsState());

  Future<void> chooseArea(PickedLocation picked) async {
    emit(state.copyWith(area: ShopsArea.fromPicked(picked), shops: const []));
    _analytics.shopsAreaChanged('custom');
    await loadShops();
  }

  Future<void> useMyLocation() async {
    if (state.usesDeviceLocation) return;

    emit(state.copyWith(clearArea: true, shops: const []));
    _analytics.shopsAreaChanged('device');
    await loadShops();
  }

  Future<void> loadShops() async {
    emit(state.copyWith(status: CustomerShopsStatus.loading));

    final GeoPoint? position = await _positionToAsk();

    final result = await _getShops(
      lat: position?.latitude,
      lng: position?.longitude,
    );

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: CustomerShopsStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (shops) => emit(
        state.copyWith(
          status: CustomerShopsStatus.success,
          shops: position == null
              ? shops
              : shops.map((shop) => shop.withDistanceFrom(position)).toList(),
          sortedByDistance: position != null,
        ),
      ),
    );
  }

  Future<GeoPoint?> _positionToAsk() async {
    return state.area?.point ?? (await _getCurrentLocation()).point;
  }
}
