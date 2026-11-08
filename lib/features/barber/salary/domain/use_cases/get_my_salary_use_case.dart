import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/member_salary.dart';
import '../repos/i_member_salary_repo.dart';

class GetMySalaryUseCase {
  final IMemberSalaryRepo _repo;

  GetMySalaryUseCase(this._repo);

  Future<Either<Failure, MemberSalary>> call({String? month}) =>
      _repo.getMine(month: month);
}
