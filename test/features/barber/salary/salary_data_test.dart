import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ayez_ahlaq/core/error/failure.dart';
import 'package:ayez_ahlaq/features/barber/salary/data/apis/member_salary_api.dart';
import 'package:ayez_ahlaq/features/barber/salary/data/apis/salary_deductions_api.dart';
import 'package:ayez_ahlaq/features/barber/salary/data/models/member_salary_model.dart';
import 'package:ayez_ahlaq/features/barber/salary/data/repos/member_salary_repo.dart';
import 'package:ayez_ahlaq/features/barber/salary/data/repos/salary_deductions_repo.dart';
import 'package:ayez_ahlaq/features/barber/salary/domain/entities/deduction_grace_rules.dart';
import 'package:ayez_ahlaq/features/barber/salary/domain/entities/salary_month.dart';
import 'package:ayez_ahlaq/features/barber/salary/domain/entities/salary_type.dart';

const _unset = {
  'barberId': 14,
  'month': '2026-11',
  'type': null,
  'amount': null,
  'workingDays': 26,
  'scheduledHours': 265.33,
  'dailyRate': null,
  'hourlyRate': null,
  'monthlyTotal': null,
  'daysWorked': 0,
  'hoursWorked': 0.00,
  'earnedByDays': null,
  'earnedByHours': null,
  'lateMinutes': 0,
  'earlyLeaveMinutes': 0,
  'absentDays': 0,
  'lateDeduction': null,
  'earlyLeaveDeduction': null,
  'absentDeduction': null,
  'deductions': null,
  'grossSalary': null,
  'netSalary': null,
  'pendingDecisions': 0,
};

const _daily = {
  'barberId': 10,
  'month': '2026-11',
  'type': 'DAILY',
  'amount': 250.0,
  'workingDays': 30,
  'scheduledHours': 719.5,
  'dailyRate': 250.0,
  'hourlyRate': 10.42,
  'monthlyTotal': 7500.0,
  'daysWorked': 4,
  'hoursWorked': 8.93,
  'earnedByDays': 1000.0,
  'earnedByHours': 93.05,
  'lateMinutes': 25,
  'earlyLeaveMinutes': 10,
  'absentDays': 1,
  'lateDeduction': 12.5,
  'earlyLeaveDeduction': 5,
  'absentDeduction': 250,
  'deductions': 267.5,
  'grossSalary': 1000.0,
  'netSalary': 732.5,
  'pendingDecisions': 2,
};

class _SalaryApi implements MemberSalaryApi {
  Map<String, dynamic> body = _daily;
  Failure? failure;
  String? month;
  int? memberId;
  SalaryType? type;
  double? amount;
  bool cleared = false;
  bool mine = false;

  Either<Failure, dynamic> get _result =>
      failure != null ? Left(failure!) : Right({'data': body});

  @override
  Future<Either<Failure, dynamic>> getMine({String? month}) async {
    mine = true;
    this.month = month;
    return _result;
  }

  @override
  Future<Either<Failure, dynamic>> getOf(int memberId, {String? month}) async {
    this.memberId = memberId;
    this.month = month;
    return _result;
  }

  @override
  Future<Either<Failure, dynamic>> set(
    int memberId, {
    required SalaryType type,
    required double amount,
  }) async {
    this.memberId = memberId;
    this.type = type;
    this.amount = amount;
    return _result;
  }

  @override
  Future<Either<Failure, dynamic>> clear(int memberId) async {
    this.memberId = memberId;
    cleared = true;
    return _result;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => throw UnimplementedError();
}

class _DeductionsApi implements SalaryDeductionsApi {
  int? sentGrace;

  @override
  Future<Either<Failure, dynamic>> pendingCount() async => const Right({
    'data': {'pending': 3},
  });

  @override
  Future<Either<Failure, dynamic>> getSetting() async => const Right({
    'data': {'graceMinutes': 15},
  });

  @override
  Future<Either<Failure, dynamic>> setSetting(int graceMinutes) async {
    sentGrace = graceMinutes;
    return Right({
      'data': {'graceMinutes': graceMinutes},
    });
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => throw UnimplementedError();
}

void main() {
  group('salary model', () {
    test('reads a salary that was never set as empty money fields', () {
      final salary = MemberSalaryModel.fromJson({..._unset});

      expect(salary.hasSalary, isFalse);
      expect(salary.type, isNull);
      expect(salary.netSalary, isNull);
      expect(salary.workingDays, 26);
      expect(salary.scheduledHours, 265.33);
      expect(salary.hasIncidents, isFalse);
    });

    test('reads a full daily salary with deductions', () {
      final salary = MemberSalaryModel.fromJson({..._daily});

      expect(salary.hasSalary, isTrue);
      expect(salary.type, SalaryType.daily);
      expect(salary.amount, 250);
      expect(salary.earlyLeaveDeduction, 5);
      expect(salary.netSalary, 732.5);
      expect(salary.pendingDecisions, 2);
      expect(salary.hasIncidents, isTrue);
    });

    test('whole numbers from the server become doubles', () {
      final salary = MemberSalaryModel.fromJson({
        ..._daily,
        'absentDeduction': 250,
      });

      expect(salary.absentDeduction, 250.0);
    });

    test('a missing field falls back to zero instead of failing', () {
      final salary = MemberSalaryModel.fromJson({'barberId': 1});

      expect(salary.daysWorked, 0);
      expect(salary.month, '');
      expect(salary.scheduledHours, 0);
    });

    test('the monthly type is understood', () {
      expect(SalaryType.fromWire('MONTHLY'), SalaryType.monthly);
      expect(SalaryType.fromWire('x'), isNull);
    });
  });

  group('salary repo', () {
    late _SalaryApi api;
    late MemberSalaryRepo repo;

    setUp(() {
      api = _SalaryApi();
      repo = MemberSalaryRepo(api);
    });

    test('gets the logged in member salary for a month', () async {
      final result = await repo.getMine(month: '2026-10');

      expect(api.mine, isTrue);
      expect(api.month, '2026-10');
      expect(result.getOrElse(() => throw StateError('x')).barberId, 10);
    });

    test('gets a member salary for the owner', () async {
      await repo.getOf(10);

      expect(api.memberId, 10);
      expect(api.month, isNull);
    });

    test('sets the type and amount', () async {
      await repo.set(10, type: SalaryType.monthly, amount: 6000);

      expect(api.type, SalaryType.monthly);
      expect(api.amount, 6000);
    });

    test('clears the salary', () async {
      final result = await repo.clear(10);

      expect(api.cleared, isTrue);
      expect(result.isRight(), isTrue);
    });

    test('a failure comes back as a failure', () async {
      api.failure = Failure('no', 403, const {});

      expect((await repo.getMine()).isLeft(), isTrue);
    });

    test('a response with no data is a failure', () async {
      final broken = _SalaryApi()..body = {};
      final result = await MemberSalaryRepo(_NoDataApi(broken)).getMine();

      expect(result.isLeft(), isTrue);
    });
  });

  group('deductions repo', () {
    test('reads the pending count and the grace', () async {
      final repo = SalaryDeductionsRepo(_DeductionsApi());

      expect(await repo.pendingCount(), const Right(3));
      expect(await repo.getGraceMinutes(), const Right(15));
    });

    test('sends the grace and returns what the server saved', () async {
      final api = _DeductionsApi();

      final result = await SalaryDeductionsRepo(api).setGraceMinutes(10);

      expect(api.sentGrace, 10);
      expect(result, const Right(10));
    });
  });

  group('rules', () {
    test('grace is from 0 to 120 minutes', () {
      expect(DeductionGraceRules.isValid(-1), isFalse);
      expect(DeductionGraceRules.isValid(0), isTrue);
      expect(DeductionGraceRules.isValid(120), isTrue);
      expect(DeductionGraceRules.isValid(121), isFalse);
    });

    test('the month is formatted for the server', () {
      expect(SalaryMonth.format(DateTime(2026, 3, 9)), '2026-03');
      expect(SalaryMonth.previous(DateTime(2026, 1)), DateTime(2025, 12));
      expect(SalaryMonth.next(DateTime(2026, 12)), DateTime(2027));
      expect(
        SalaryMonth.isSameMonth(DateTime(2026, 5, 1), DateTime(2026, 5, 30)),
        isTrue,
      );
    });
  });
}

class _NoDataApi implements MemberSalaryApi {
  final _SalaryApi inner;
  _NoDataApi(this.inner);

  @override
  Future<Either<Failure, dynamic>> getMine({String? month}) async =>
      const Right({'data': null});

  @override
  dynamic noSuchMethod(Invocation invocation) => throw UnimplementedError();
}
