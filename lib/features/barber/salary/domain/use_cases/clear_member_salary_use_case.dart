import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/member_salary.dart';
import '../repos/i_member_salary_repo.dart';

class ClearMemberSalaryUseCase {
  final IMemberSalaryRepo _repo;

  ClearMemberSalaryUseCase(this._repo);

  Future<Either<Failure, MemberSalary>> call(int memberId) =>
      _repo.clear(memberId);
}
