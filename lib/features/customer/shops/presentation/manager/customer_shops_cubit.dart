import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../shared/location/current_position_resolver.dart';
import '../../domain/use_cases/get_shops_use_case.dart';
import 'customer_shops_state.dart';

class CustomerShopsCubit extends Cubit<CustomerShopsState> {
  final GetShopsUseCase _getShops;
  final CurrentPositionResolver _positionResolver;

  CustomerShopsCubit(this._getShops, this._positionResolver)
      : super(const CustomerShopsState());

  Future<void> loadShops() async {
    emit(state.copyWith(status: CustomerShopsStatus.loading));

    final position = await _positionResolver.resolve();

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
}
