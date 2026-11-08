import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../repos/i_salary_deductions_repo.dart';

class GetDeductionGraceUseCase {
  final ISalaryDeductionsRepo _repo;

  GetDeductionGraceUseCase(this._repo);

  Future<Either<Failure, int>> call() => _repo.getGraceMinutes();
}
