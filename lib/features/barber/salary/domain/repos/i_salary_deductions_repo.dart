import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';

abstract class ISalaryDeductionsRepo {
  Future<Either<Failure, int>> pendingCount();

  Future<Either<Failure, int>> getGraceMinutes();

  Future<Either<Failure, int>> setGraceMinutes(int minutes);
}
