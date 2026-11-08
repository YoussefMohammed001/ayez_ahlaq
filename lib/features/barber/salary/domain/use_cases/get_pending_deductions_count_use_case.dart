import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../repos/i_salary_deductions_repo.dart';

class GetPendingDeductionsCountUseCase {
  final ISalaryDeductionsRepo _repo;

  GetPendingDeductionsCountUseCase(this._repo);

  Future<Either<Failure, int>> call() => _repo.pendingCount();
}
