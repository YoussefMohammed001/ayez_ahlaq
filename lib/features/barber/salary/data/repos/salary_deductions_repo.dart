import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/network/response_guard.dart';
import '../../domain/entities/deduction_status.dart';
import '../../domain/entities/salary_deduction.dart';
import '../../domain/entities/salary_deductions_page.dart';
import '../../domain/repos/i_salary_deductions_repo.dart';
import '../apis/salary_deductions_api.dart';
import '../models/salary_deduction_model.dart';
import '../models/salary_deductions_page_model.dart';

class SalaryDeductionsRepo implements ISalaryDeductionsRepo {
  static const _pageSize = 20;

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

  @override
  Future<Either<Failure, SalaryDeductionsPage>> list({
    required int page,
    DeductionStatus? status,
    int? barberId,
    String? month,
  }) async {
    final result = await _api.list(
      page: page,
      size: _pageSize,
      status: status,
      barberId: barberId,
      month: month,
    );
    return result.flatMap(
      (response) =>
          requireDataMap(response).map(SalaryDeductionsPageModel.fromJson),
    );
  }

  @override
  Future<Either<Failure, SalaryDeduction>> decide(
    int id, {
    required bool waive,
    String? note,
  }) async {
    final result = await _api.decide(id, waive: waive, note: note);
    return result.flatMap(
      (response) => requireDataMap(response).map(SalaryDeductionModel.fromJson),
    );
  }

  Either<Failure, int> _intOf(dynamic response, String key) =>
      requireDataMap(response).map((data) => (data[key] as num?)?.toInt() ?? 0);
}
