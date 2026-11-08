import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/network/response_guard.dart';
import '../../domain/entities/member_salary.dart';
import '../../domain/entities/salary_type.dart';
import '../../domain/repos/i_member_salary_repo.dart';
import '../apis/member_salary_api.dart';
import '../models/member_salary_model.dart';

class MemberSalaryRepo implements IMemberSalaryRepo {
  final MemberSalaryApi _api;

  MemberSalaryRepo(this._api);

  @override
  Future<Either<Failure, MemberSalary>> getMine({String? month}) async {
    final result = await _api.getMine(month: month);
    return result.flatMap(_salaryFrom);
  }

  @override
  Future<Either<Failure, MemberSalary>> getOf(
    int memberId, {
    String? month,
  }) async {
    final result = await _api.getOf(memberId, month: month);
    return result.flatMap(_salaryFrom);
  }

  @override
  Future<Either<Failure, MemberSalary>> set(
    int memberId, {
    required SalaryType type,
    required double amount,
  }) async {
    final result = await _api.set(memberId, type: type, amount: amount);
    return result.flatMap(_salaryFrom);
  }

  @override
  Future<Either<Failure, MemberSalary>> clear(int memberId) async {
    final result = await _api.clear(memberId);
    return result.flatMap(_salaryFrom);
  }

  Either<Failure, MemberSalary> _salaryFrom(dynamic response) =>
      requireDataMap(response).map(MemberSalaryModel.fromJson);
}
