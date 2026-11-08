import 'package:flutter_test/flutter_test.dart';
import 'package:ayez_ahlaq/core/error/failure.dart';
import 'package:ayez_ahlaq/features/barber/salary/domain/entities/deduction_status.dart';
import 'package:ayez_ahlaq/features/barber/salary/domain/use_cases/decide_deduction_use_case.dart';
import 'package:ayez_ahlaq/features/barber/salary/domain/use_cases/get_deduction_grace_use_case.dart';
import 'package:ayez_ahlaq/features/barber/salary/domain/use_cases/get_pending_deductions_count_use_case.dart';
import 'package:ayez_ahlaq/features/barber/salary/domain/use_cases/get_salary_deductions_use_case.dart';
import 'package:ayez_ahlaq/features/barber/salary/domain/use_cases/set_deduction_grace_use_case.dart';
import 'package:ayez_ahlaq/features/barber/salary/presentation/manager/deduction_grace_cubit.dart';
import 'package:ayez_ahlaq/features/barber/salary/presentation/manager/deduction_grace_state.dart';
import 'package:ayez_ahlaq/features/barber/salary/presentation/manager/pending_deductions_count_cubit.dart';
import 'package:ayez_ahlaq/features/barber/salary/presentation/manager/salary_deductions_cubit.dart';
import 'package:ayez_ahlaq/features/barber/salary/presentation/manager/salary_deductions_state.dart';
import 'salary_test_doubles.dart';

void main() {
  late FakeDeductionsRepo repo;

  SalaryDeductionsCubit build() => SalaryDeductionsCubit(
    GetSalaryDeductionsUseCase(repo),
    DecideDeductionUseCase(repo),
    GetPendingDeductionsCountUseCase(repo),
  );

  setUp(() {
    repo = FakeDeductionsRepo([
      deductionOf(3),
      deductionOf(2, status: DeductionStatus.deducted),
      deductionOf(1, status: DeductionStatus.waived),
    ])..pending = 1;
  });

  group('list', () {
    test('loads the first page and the pending count', () async {
      final cubit = build();

      await cubit.load();

      expect(cubit.state.status, SalaryDeductionsStatus.success);
      expect(cubit.state.items.map((i) => i.id), [3, 2, 1]);
      expect(cubit.state.pendingCount, 1);
    });

    test('a failure is reported and keeps the list empty', () async {
      repo.failure = Failure('boom', 500, const {});
      final cubit = build();

      await cubit.load();

      expect(cubit.state.status, SalaryDeductionsStatus.failure);
      expect(cubit.state.errorMessage, 'boom');
    });

    test('filtering asks the server for that status', () async {
      final cubit = build();
      await cubit.load();

      await cubit.setFilter(DeductionStatus.waived);

      expect(repo.requests.last.status, DeductionStatus.waived);
      expect(cubit.state.items.map((i) => i.id), [1]);
      expect(cubit.state.filter, DeductionStatus.waived);
    });

    test('clearing the filter shows everything again', () async {
      final cubit = build();
      await cubit.setFilter(DeductionStatus.waived);

      await cubit.setFilter(null);

      expect(cubit.state.filter, isNull);
      expect(cubit.state.items, hasLength(3));
    });

    test('scrolling loads the next page until the end', () async {
      repo = FakeDeductionsRepo([for (var i = 1; i <= 5; i++) deductionOf(i)])
        ..pageSize = 2;
      final cubit = build();
      await cubit.load();
      expect(cubit.state.hasMore, isTrue);

      await cubit.loadMore();
      await cubit.loadMore();
      await cubit.loadMore();

      expect(cubit.state.items.map((i) => i.id), [1, 2, 3, 4, 5]);
      expect(cubit.state.hasMore, isFalse);
      expect(repo.requests.map((r) => r.page), [0, 1, 2]);
    });

    test('nothing more to load does not ask again', () async {
      final cubit = build();
      await cubit.load();

      await cubit.loadMore();

      expect(repo.requests, hasLength(1));
    });
  });

  group('deciding', () {
    test('waiving updates the row and the pending count', () async {
      final cubit = build();
      await cubit.load();

      final done = await cubit.decide(3, waive: true, note: 'ok');

      expect(done, isTrue);
      expect(repo.lastDecision, (id: 3, waive: true, note: 'ok'));
      expect(cubit.state.items.first.status, DeductionStatus.waived);
      expect(cubit.state.items.first.decisionNote, 'ok');
      expect(cubit.state.pendingCount, 0);
      expect(cubit.state.isDeciding, isFalse);
    });

    test('confirming marks the deduction as taken', () async {
      final cubit = build();
      await cubit.load();

      await cubit.decide(3, waive: false);

      expect(cubit.state.items.first.status, DeductionStatus.deducted);
    });

    test('a decided row leaves a list filtered on pending', () async {
      final cubit = build();
      await cubit.setFilter(DeductionStatus.pending);
      expect(cubit.state.items.map((i) => i.id), [3]);

      await cubit.decide(3, waive: true);

      expect(cubit.state.items, isEmpty);
    });

    test('a rejected decision keeps the row and shows why', () async {
      repo.decideFailure = Failure('nope', 403, const {});
      final cubit = build();
      await cubit.load();

      final done = await cubit.decide(3, waive: true);

      expect(done, isFalse);
      expect(cubit.state.items.first.status, DeductionStatus.pending);
      expect(cubit.state.errorMessage, 'nope');
      expect(cubit.state.isDeciding, isFalse);
    });
  });

  group('pending badge', () {
    test('loads the number waiting', () async {
      repo.pending = 4;
      final cubit = PendingDeductionsCountCubit(
        GetPendingDeductionsCountUseCase(repo),
      );

      await cubit.load();

      expect(cubit.state, 4);
    });
  });

  group('grace', () {
    DeductionGraceCubit graceCubit() => DeductionGraceCubit(
      GetDeductionGraceUseCase(repo),
      SetDeductionGraceUseCase(repo),
    );

    test('loads the saved minutes', () async {
      repo.grace = 15;
      final cubit = graceCubit();

      await cubit.load();

      expect(cubit.state.status, DeductionGraceStatus.success);
      expect(cubit.state.minutes, 15);
    });

    test('saves and keeps what the server returned', () async {
      final cubit = graceCubit();
      await cubit.load();

      final saved = await cubit.save(10);

      expect(saved, isTrue);
      expect(cubit.state.minutes, 10);
      expect(cubit.state.isSaving, isFalse);
    });

    test('a rejected save keeps the old value', () async {
      repo.grace = 5;
      final cubit = graceCubit();
      await cubit.load();
      repo.failure = Failure('bad', 400, const {});

      final saved = await cubit.save(500);

      expect(saved, isFalse);
      expect(cubit.state.minutes, 5);
      expect(cubit.state.errorMessage, 'bad');
    });
  });
}
