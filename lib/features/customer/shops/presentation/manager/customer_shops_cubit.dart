import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import '../../domain/use_cases/get_shops_use_case.dart';
import 'customer_shops_state.dart';

class CustomerShopsCubit extends Cubit<CustomerShopsState> {
  final GetShopsUseCase _getShops;

  CustomerShopsCubit(this._getShops) : super(const CustomerShopsState());

  Future<void> loadShops() async {
    emit(state.copyWith(status: CustomerShopsStatus.loading));

    final position = await _resolveCurrentPosition();

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
          shops: shops,
          sortedByDistance: position != null,
        ),
      ),
    );
  }

  Future<Position?> _resolveCurrentPosition() async {
    try {
      if (!await Geolocator.isLocationServiceEnabled()) return null;

      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        return null;
      }

      return await Geolocator.getCurrentPosition();
    } catch (_) {
      return null;
    }
  }
}
