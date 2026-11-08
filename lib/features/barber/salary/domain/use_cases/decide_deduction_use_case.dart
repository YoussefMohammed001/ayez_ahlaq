import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/salary_deduction.dart';
import '../repos/i_salary_deductions_repo.dart';

class DecideDeductionUseCase {
  final ISalaryDeductionsRepo _repo;

  DecideDeductionUseCase(this._repo);

  Future<Either<Failure, SalaryDeduction>> call(
    int id, {
    required bool waive,
    String? note,
  }) => _repo.decide(id, waive: waive, note: note);
}
