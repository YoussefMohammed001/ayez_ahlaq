import 'package:dartz/dartz.dart';
import 'package:ayez_ahlaq/core/error/failure.dart';
import 'package:ayez_ahlaq/features/barber/salary/domain/entities/member_salary.dart';
import 'package:ayez_ahlaq/features/barber/salary/domain/entities/salary_type.dart';
import 'package:ayez_ahlaq/features/barber/salary/domain/repos/i_member_salary_repo.dart';

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
