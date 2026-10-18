import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../shared/location/domain/use_cases/get_current_location_use_case.dart';
import '../../domain/use_cases/get_shops_use_case.dart';
import 'customer_shops_state.dart';

class CustomerShopsCubit extends Cubit<CustomerShopsState> {
  final GetShopsUseCase _getShops;
  final GetCurrentLocationUseCase _getCurrentLocation;

  CustomerShopsCubit(this._getShops, this._getCurrentLocation)
    : super(const CustomerShopsState());

  Future<void> loadShops() async {
    emit(state.copyWith(status: CustomerShopsStatus.loading));

    final position = (await _getCurrentLocation()).point;

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
}
