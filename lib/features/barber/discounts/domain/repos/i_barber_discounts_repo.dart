import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../data/requests/barber_discount_request.dart';
import '../entities/barber_discount.dart';

abstract class IBarberDiscountsRepo {
  Future<Either<Failure, List<BarberDiscount>>> getDiscounts();

  Future<Either<Failure, BarberDiscount>> getDiscountById(int id);

  Future<Either<Failure, BarberDiscount>> createDiscount(
    BarberDiscountRequest request,
  );

  Future<Either<Failure, BarberDiscount>> updateDiscount(
    int id,
    BarberDiscountRequest request,
  );

  Future<Either<Failure, Unit>> closeDiscount(int id);
}
