import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/network/response_guard.dart';
import '../../domain/repos/i_salary_deductions_repo.dart';
import '../apis/salary_deductions_api.dart';

class SalaryDeductionsRepo implements ISalaryDeductionsRepo {
  final SalaryDeductionsApi _api;

  SalaryDeductionsRepo(this._api);

  @override
  Future<Either<Failure, int>> pendingCount() async {
    final result = await _api.pendingCount();
    return result.flatMap((response) => _intOf(response, 'pending'));
  }

  @override
  Future<Either<Failure, int>> getGraceMinutes() async {
    final result = await _api.getSetting();
    return result.flatMap((response) => _intOf(response, 'graceMinutes'));
  }

  @override
  Future<Either<Failure, int>> setGraceMinutes(int minutes) async {
    final result = await _api.setSetting(minutes);
    return result.flatMap((response) => _intOf(response, 'graceMinutes'));
  }

  Either<Failure, int> _intOf(dynamic response, String key) =>
      requireDataMap(response).map((data) => (data[key] as num?)?.toInt() ?? 0);
}
