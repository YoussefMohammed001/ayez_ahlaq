import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/shop_haircut_style.dart';
import '../repos/i_barber_services_repo.dart';

class UpdateShopHaircutStyleUseCase {
  final IBarberServicesRepo _repo;

  UpdateShopHaircutStyleUseCase(this._repo);

  Future<Either<Failure, ShopHaircutStyle>> call(
    int id, {
    required int priceDelta,
    required bool active,
  }) => _repo.updateHaircutStyle(id, priceDelta: priceDelta, active: active);
}
