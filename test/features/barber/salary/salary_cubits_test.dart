import 'package:flutter_test/flutter_test.dart';
import 'package:ayez_ahlaq/core/error/failure.dart';
import 'package:ayez_ahlaq/features/barber/salary/domain/entities/salary_type.dart';
import 'package:ayez_ahlaq/features/barber/salary/domain/use_cases/clear_member_salary_use_case.dart';
import 'package:ayez_ahlaq/features/barber/salary/domain/use_cases/get_member_salary_use_case.dart';
import 'package:ayez_ahlaq/features/barber/salary/domain/use_cases/get_my_salary_use_case.dart';
import 'package:ayez_ahlaq/features/barber/salary/domain/use_cases/set_member_salary_use_case.dart';
import 'package:ayez_ahlaq/features/barber/salary/presentation/manager/member_salary_cubit.dart';
import 'package:ayez_ahlaq/features/barber/salary/presentation/manager/my_salary_cubit.dart';
import 'package:ayez_ahlaq/features/barber/salary/presentation/manager/salary_view_state.dart';
import 'salary_test_doubles.dart';

final _now = DateTime(2026, 11, 8);

void main() {
  late FakeSalaryRepo repo;

  MemberSalaryCubit owner() => MemberSalaryCubit(
    GetMemberSalaryUseCase(repo),
    SetMemberSalaryUseCase(repo),
    ClearMemberSalaryUseCase(repo),
    clock: () => _now,
  );

  MySalaryCubit member() =>
      MySalaryCubit(GetMySalaryUseCase(repo), clock: () => _now);

  setUp(() => repo = FakeSalaryRepo());

  group('viewing', () {
    test('starts on the current month and loads it', () async {
      final cubit = owner();

      await cubit.loadMember(10);

      expect(cubit.state.status, SalaryViewStatus.success);
      expect(cubit.state.month, DateTime(2026, 11));
      expect(repo.requestedMonths, ['2026-11']);
      expect(cubit.state.salary?.barberId, 10);
    });

    test('a failed load reports it and keeps no salary', () async {
      repo.failure = Failure('boom', 500, const {});
      final cubit = owner();

      await cubit.loadMember(10);

      expect(cubit.state.status, SalaryViewStatus.failure);
      expect(cubit.state.errorMessage, 'boom');
      expect(cubit.state.salary, isNull);
    });

    test('going back a month loads that month', () async {
      final cubit = owner();
      await cubit.loadMember(10);

      await cubit.previousMonth();

      expect(cubit.state.month, DateTime(2026, 10));
      expect(repo.requestedMonths.last, '2026-10');
    });

    test('the next month is blocked from the current month', () async {
      final cubit = owner();
      await cubit.loadMember(10);

      expect(cubit.state.canShowNext(_now), isFalse);
      await cubit.nextMonth();

      expect(repo.calls, 1);
      expect(cubit.state.month, DateTime(2026, 11));
    });

    test('going back then forward returns to the current month', () async {
      final cubit = owner();
      await cubit.loadMember(10);
      await cubit.previousMonth();
      await cubit.previousMonth();

      expect(cubit.state.canShowNext(_now), isTrue);
      await cubit.nextMonth();
      await cubit.nextMonth();

      expect(cubit.state.month, DateTime(2026, 11));
      expect(repo.requestedMonths.last, '2026-11');
    });

    test('the year rolls over when going back from January', () async {
      final january = MemberSalaryCubit(
        GetMemberSalaryUseCase(repo),
        SetMemberSalaryUseCase(repo),
        ClearMemberSalaryUseCase(repo),
        clock: () => DateTime(2026, 1, 15),
      );
      await january.loadMember(10);

      await january.previousMonth();

      expect(repo.requestedMonths.last, '2025-12');
    });

    test('the member view loads their own salary', () async {
      final cubit = member();

      await cubit.load();

      expect(cubit.state.status, SalaryViewStatus.success);
      expect(repo.requestedMonths, ['2026-11']);
    });
  });

  group('owner changes', () {
    test('saving a salary reloads the view with it', () async {
      final cubit = owner();
      await cubit.loadMember(10);

      final saved = await cubit.save(type: SalaryType.daily, amount: 250);

      expect(saved, isTrue);
      expect(cubit.state.isSaving, isFalse);
      expect(cubit.state.salary?.type, SalaryType.daily);
      expect(cubit.state.salary?.amount, 250);
    });

    test('a rejected save keeps the old salary and shows why', () async {
      final cubit = owner();
      await cubit.loadMember(10);
      repo.writeFailure = Failure(
        'amount: the salary must be greater than zero',
        400,
        const {},
      );

      final saved = await cubit.save(type: SalaryType.monthly, amount: 0);

      expect(saved, isFalse);
      expect(cubit.state.isSaving, isFalse);
      expect(cubit.state.errorMessage, contains('greater than zero'));
      expect(cubit.state.salary?.hasSalary, isFalse);
    });

    test('clearing removes the salary', () async {
      final cubit = owner();
      await cubit.loadMember(10);
      await cubit.save(type: SalaryType.monthly, amount: 6000);

      final cleared = await cubit.clear();

      expect(cleared, isTrue);
      expect(cubit.state.salary?.hasSalary, isFalse);
    });

    test('saving while looking at another month reloads that month', () async {
      final cubit = owner();
      await cubit.loadMember(10);
      await cubit.previousMonth();

      await cubit.save(type: SalaryType.daily, amount: 100);

      expect(repo.requestedMonths.last, '2026-10');
    });
  });
}
