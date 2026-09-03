import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/earnings.dart';

abstract class IBarberEarningsRepo {
  Future<Either<Failure, Earnings>> getEarnings();
}
