import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/deduction_status.dart';
import '../entities/salary_deductions_page.dart';
import '../repos/i_salary_deductions_repo.dart';

class GetSalaryDeductionsUseCase {
  final ISalaryDeductionsRepo _repo;

  GetSalaryDeductionsUseCase(this._repo);

  Future<Either<Failure, SalaryDeductionsPage>> call({
    required int page,
    DeductionStatus? status,
    int? barberId,
    String? month,
  }) =>
      _repo.list(page: page, status: status, barberId: barberId, month: month);
}
