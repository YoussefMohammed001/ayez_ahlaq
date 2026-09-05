import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/shop.dart';
import '../entities/shop_detail.dart';

abstract class ICustomerShopsRepo {
  Future<Either<Failure, List<Shop>>> getShops({double? lat, double? lng});

  Future<Either<Failure, ShopDetail>> getShopDetail(int shopId);
}
