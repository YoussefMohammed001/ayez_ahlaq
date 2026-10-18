import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../shared/location/domain/use_cases/get_current_location_use_case.dart';
import '../../domain/use_cases/get_home_service_shops_use_case.dart';
import 'home_service_shops_state.dart';

class HomeServiceShopsCubit extends Cubit<HomeServiceShopsState> {
  final GetHomeServiceShopsUseCase _getShops;
  final GetCurrentLocationUseCase _getCurrentLocation;

  HomeServiceShopsCubit(this._getShops, this._getCurrentLocation)
    : super(const HomeServiceShopsState());

  Future<void> loadShops({
    required String date,
    required String time,
    bool isRefresh = false,
  }) async {
    emit(
      isRefresh
          ? state.copyWith(status: HomeServiceShopsStatus.loading)
          : const HomeServiceShopsState(status: HomeServiceShopsStatus.loading),
    );

    final position = (await _getCurrentLocation()).point;

    final result = await _getShops(
      date: date,
      time: time,
      lat: position?.latitude,
      lng: position?.longitude,
    );

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: HomeServiceShopsStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (shops) => emit(
        state.copyWith(
          status: HomeServiceShopsStatus.success,
          shops: position == null
              ? shops
              : shops.map((shop) => shop.withDistanceFrom(position)).toList(),
          sortedByDistance: position != null,
        ),
      ),
    );
  }
}
