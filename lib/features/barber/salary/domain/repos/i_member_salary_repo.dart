import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/member_salary.dart';
import '../entities/salary_type.dart';

abstract class IMemberSalaryRepo {
  Future<Either<Failure, MemberSalary>> getMine({String? month});

  Future<Either<Failure, MemberSalary>> getOf(int memberId, {String? month});

  Future<Either<Failure, MemberSalary>> set(
    int memberId, {
    required SalaryType type,
    required double amount,
  });

  Future<Either<Failure, MemberSalary>> clear(int memberId);
}
