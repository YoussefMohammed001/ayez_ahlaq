import 'package:dartz/dartz.dart';
import 'package:ayez_ahlaq/core/error/failure.dart';
import 'package:ayez_ahlaq/features/barber/salary/domain/entities/deduction_kind.dart';
import 'package:ayez_ahlaq/features/barber/salary/domain/entities/deduction_status.dart';
import 'package:ayez_ahlaq/features/barber/salary/domain/entities/member_salary.dart';
import 'package:ayez_ahlaq/features/barber/salary/domain/entities/salary_deduction.dart';
import 'package:ayez_ahlaq/features/barber/salary/domain/entities/salary_deductions_page.dart';
import 'package:ayez_ahlaq/features/barber/salary/domain/entities/salary_type.dart';
import 'package:ayez_ahlaq/features/barber/salary/domain/repos/i_member_salary_repo.dart';
import 'package:ayez_ahlaq/features/barber/salary/domain/repos/i_salary_deductions_repo.dart';

MemberSalary salaryOf({
  SalaryType? type,
  double? amount,
  String month = '2026-11',
  int daysWorked = 4,
  int lateMinutes = 0,
  int absentDays = 0,
  double? net,
}) => MemberSalary(
  barberId: 10,
  month: month,
  type: type,
  amount: amount,
  workingDays: 30,
  scheduledHours: 719.5,
  dailyRate: type == null ? null : 250,
  hourlyRate: type == null ? null : 10.42,
  monthlyTotal: type == null ? null : 7500,
  daysWorked: daysWorked,
  hoursWorked: 8.93,
  earnedByDays: null,
  earnedByHours: null,
  lateMinutes: lateMinutes,
  earlyLeaveMinutes: 0,
  absentDays: absentDays,
  lateDeduction: null,
  earlyLeaveDeduction: null,
  absentDeduction: null,
  deductions: type == null ? null : 0,
  grossSalary: type == null ? null : 1000,
  netSalary: net ?? (type == null ? null : 1000),
  pendingDecisions: 0,
);

class FakeSalaryRepo implements IMemberSalaryRepo {
  SalaryType? type;
  double? amount;
  Failure? failure;
  Failure? writeFailure;
  final requestedMonths = <String?>[];
  int calls = 0;

  MemberSalary get _current => salaryOf(type: type, amount: amount);

  Either<Failure, MemberSalary> _read(String? month) {
    calls++;
    requestedMonths.add(month);
    if (failure != null) return Left(failure!);
    return Right(
      salaryOf(type: type, amount: amount, month: month ?? '2026-11'),
    );
  }

  @override
  Future<Either<Failure, MemberSalary>> getMine({String? month}) async =>
      _read(month);

  @override
  Future<Either<Failure, MemberSalary>> getOf(
    int memberId, {
    String? month,
  }) async => _read(month);

  @override
  Future<Either<Failure, MemberSalary>> set(
    int memberId, {
    required SalaryType type,
    required double amount,
  }) async {
    if (writeFailure != null) return Left(writeFailure!);
    this.type = type;
    this.amount = amount;
    return Right(_current);
  }

  @override
  Future<Either<Failure, MemberSalary>> clear(int memberId) async {
    if (writeFailure != null) return Left(writeFailure!);
    type = null;
    amount = null;
    return Right(_current);
  }
}

SalaryDeduction deductionOf(
  int id, {
  DeductionStatus status = DeductionStatus.pending,
  DeductionKind kind = DeductionKind.late,
  int minutes = 30,
  double amount = 40,
  String? note,
}) => SalaryDeduction(
  id: id,
  barberId: 10,
  barberName: 'كريم',
  workDate: DateTime(2026, 11, 8),
  kind: kind,
  minutes: minutes,
  amount: amount,
  status: status,
  decisionNote: note,
);

class FakeDeductionsRepo implements ISalaryDeductionsRepo {
  final List<SalaryDeduction> all;
  Failure? failure;
  Failure? decideFailure;
  int pending = 0;
  int grace = 0;
  int pageSize = 20;
  final requests = <({int page, DeductionStatus? status})>[];
  ({int id, bool waive, String? note})? lastDecision;

  FakeDeductionsRepo(this.all);

  @override
  Future<Either<Failure, int>> pendingCount() async => Right(pending);

  @override
  Future<Either<Failure, int>> getGraceMinutes() async => Right(grace);

  @override
  Future<Either<Failure, int>> setGraceMinutes(int minutes) async {
    if (failure != null) return Left(failure!);
    grace = minutes;
    return Right(grace);
  }

  @override
  Future<Either<Failure, SalaryDeductionsPage>> list({
    required int page,
    DeductionStatus? status,
    int? barberId,
    String? month,
  }) async {
    requests.add((page: page, status: status));
    if (failure != null) return Left(failure!);

    final matching = [
      for (final item in all)
        if (status == null || item.status == status) item,
    ];
    final pages = (matching.length / pageSize).ceil();
    final start = page * pageSize;

    return Right(
      SalaryDeductionsPage(
        items: matching.skip(start).take(pageSize).toList(),
        page: page,
        totalPages: pages,
      ),
    );
  }

  @override
  Future<Either<Failure, SalaryDeduction>> decide(
    int id, {
    required bool waive,
    String? note,
  }) async {
    if (decideFailure != null) return Left(decideFailure!);
    lastDecision = (id: id, waive: waive, note: note);

    final index = all.indexWhere((item) => item.id == id);
    final updated = deductionOf(
      id,
      status: waive ? DeductionStatus.waived : DeductionStatus.deducted,
      note: note,
    );
    all[index] = updated;
    pending = all.where((i) => i.status == DeductionStatus.pending).length;
    return Right(updated);
  }
}
