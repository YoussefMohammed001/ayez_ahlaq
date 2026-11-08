import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../repos/i_salary_deductions_repo.dart';

class SetDeductionGraceUseCase {
  final ISalaryDeductionsRepo _repo;

  SetDeductionGraceUseCase(this._repo);

  Future<Either<Failure, int>> call(int minutes) =>
      _repo.setGraceMinutes(minutes);
}
