import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/member_salary.dart';
import '../repos/i_member_salary_repo.dart';

class GetMemberSalaryUseCase {
  final IMemberSalaryRepo _repo;

  GetMemberSalaryUseCase(this._repo);

  Future<Either<Failure, MemberSalary>> call(int memberId, {String? month}) =>
      _repo.getOf(memberId, month: month);
}
