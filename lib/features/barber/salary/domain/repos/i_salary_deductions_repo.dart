import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/deduction_status.dart';
import '../entities/salary_deduction.dart';
import '../entities/salary_deductions_page.dart';

abstract class ISalaryDeductionsRepo {
  Future<Either<Failure, int>> pendingCount();

  Future<Either<Failure, int>> getGraceMinutes();

  Future<Either<Failure, int>> setGraceMinutes(int minutes);

  Future<Either<Failure, SalaryDeductionsPage>> list({
    required int page,
    DeductionStatus? status,
    int? barberId,
    String? month,
  });

  Future<Either<Failure, SalaryDeduction>> decide(
    int id, {
    required bool waive,
    String? note,
  });
}
