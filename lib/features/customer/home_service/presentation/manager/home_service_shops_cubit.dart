import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../shared/location/current_position_resolver.dart';
import '../../domain/use_cases/get_home_service_shops_use_case.dart';
import 'home_service_shops_state.dart';

class HomeServiceShopsCubit extends Cubit<HomeServiceShopsState> {
  final GetHomeServiceShopsUseCase _getShops;
  final CurrentPositionResolver _positionResolver;

  HomeServiceShopsCubit(this._getShops, this._positionResolver)
      : super(const HomeServiceShopsState());

  Future<void> loadShops() async {
    emit(state.copyWith(status: HomeServiceShopsStatus.loading));

    final position = await _positionResolver.resolve();

    final result = await _getShops(
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
          shops: shops,
          sortedByDistance: position != null,
        ),
      ),
    );
  }
}
