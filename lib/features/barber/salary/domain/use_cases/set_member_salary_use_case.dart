import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/member_salary.dart';
import '../entities/salary_type.dart';
import '../repos/i_member_salary_repo.dart';

class SetMemberSalaryUseCase {
  final IMemberSalaryRepo _repo;

  SetMemberSalaryUseCase(this._repo);

  Future<Either<Failure, MemberSalary>> call(
    int memberId, {
    required SalaryType type,
    required double amount,
  }) => _repo.set(memberId, type: type, amount: amount);
}
