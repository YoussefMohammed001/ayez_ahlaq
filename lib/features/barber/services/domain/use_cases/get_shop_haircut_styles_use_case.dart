import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/shop_haircut_style.dart';
import '../repos/i_barber_services_repo.dart';

class GetShopHaircutStylesUseCase {
  final IBarberServicesRepo _repo;

  GetShopHaircutStylesUseCase(this._repo);

  Future<Either<Failure, List<ShopHaircutStyle>>> call() =>
      _repo.getHaircutStyles();
}
