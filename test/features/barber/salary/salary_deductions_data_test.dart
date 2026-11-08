import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ayez_ahlaq/core/error/failure.dart';
import 'package:ayez_ahlaq/features/barber/salary/data/apis/salary_deductions_api.dart';
import 'package:ayez_ahlaq/features/barber/salary/data/models/salary_deduction_model.dart';
import 'package:ayez_ahlaq/features/barber/salary/data/models/salary_deductions_page_model.dart';
import 'package:ayez_ahlaq/features/barber/salary/data/repos/salary_deductions_repo.dart';
import 'package:ayez_ahlaq/features/barber/salary/domain/entities/deduction_kind.dart';
import 'package:ayez_ahlaq/features/barber/salary/domain/entities/deduction_status.dart';

const _late = {
  'id': 3,
  'barberId': 10,
  'barberName': 'كريم',
  'workDate': '2026-11-08',
  'kind': 'LATE',
  'minutes': 222,
  'amount': 168.17,
  'status': 'PENDING',
  'deducted': true,
  'decided': false,
  'decidedAt': null,
  'decisionNote': null,
};

const _waived = {
  'id': 1,
  'barberId': 10,
  'barberName': 'كريم',
  'workDate': '2026-11-06',
  'kind': 'ABSENT',
  'minutes': 0,
  'amount': 0.0,
  'status': 'WAIVED',
  'deducted': false,
  'decided': true,
  'decidedAt': '2026-11-08T21:45:42.457461491',
  'decisionNote': 'تجربة إعفاء',
};

class _Api implements SalaryDeductionsApi {
  Map<String, dynamic>? query;
  Map<String, dynamic>? decision;
  Object body = {
    'content': [_late, _waived],
    'page': 0,
    'size': 20,
    'totalElements': 2,
    'totalPages': 1,
  };

  @override
  Future<Either<Failure, dynamic>> list({
    required int page,
    required int size,
    DeductionStatus? status,
    int? barberId,
    String? month,
  }) async {
    query = {
      'page': page,
      'size': size,
      'status': status,
      'barberId': barberId,
      'month': month,
    };
    return Right({'data': body});
  }

  @override
  Future<Either<Failure, dynamic>> decide(
    int id, {
    required bool waive,
    String? note,
  }) async {
    decision = {'id': id, 'waive': waive, 'note': note};
    return const Right({'data': _waived});
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => throw UnimplementedError();
}

void main() {
  group('deduction model', () {
    test('reads a real late row from the server', () {
      final row = SalaryDeductionModel.fromJson({..._late});

      expect(row.id, 3);
      expect(row.kind, DeductionKind.late);
      expect(row.status, DeductionStatus.pending);
      expect(row.minutes, 222);
      expect(row.amount, 168.17);
      expect(row.workDate, DateTime(2026, 11, 8));
      expect(row.decisionNote, isNull);
      expect(row.isDecided, isFalse);
      expect(row.isDeducted, isTrue);
    });

    test('reads a waived row with its note', () {
      final row = SalaryDeductionModel.fromJson({..._waived});

      expect(row.kind, DeductionKind.absent);
      expect(row.status, DeductionStatus.waived);
      expect(row.decisionNote, 'تجربة إعفاء');
      expect(row.isDecided, isTrue);
      expect(row.isDeducted, isFalse);
    });

    test('an unknown kind and a blank note are tolerated', () {
      final row = SalaryDeductionModel.fromJson({
        ..._late,
        'kind': 'SOMETHING_NEW',
        'decisionNote': '  ',
      });

      expect(row.kind, DeductionKind.other);
      expect(row.decisionNote, isNull);
    });

    test('missing fields fall back to safe values', () {
      final row = SalaryDeductionModel.fromJson({'id': 5});

      expect(row.barberName, '');
      expect(row.minutes, 0);
      expect(row.status, DeductionStatus.pending);
    });

    test('the early leave kind is understood', () {
      expect(DeductionKind.fromWire('EARLY_LEAVE'), DeductionKind.earlyLeave);
    });
  });

  group('page model', () {
    test('reads the rows and the paging', () {
      final page = SalaryDeductionsPageModel.fromJson({
        'content': [_late, _waived],
        'page': 1,
        'totalPages': 3,
      });

      expect(page.items.map((i) => i.id), [3, 1]);
      expect(page.hasMore, isTrue);
    });

    test('the last page has no more', () {
      final page = SalaryDeductionsPageModel.fromJson({
        'content': [],
        'page': 2,
        'totalPages': 3,
      });

      expect(page.hasMore, isFalse);
      expect(page.items, isEmpty);
    });

    test('a page without content is empty', () {
      expect(SalaryDeductionsPageModel.fromJson({}).items, isEmpty);
    });
  });

  group('repo', () {
    test('asks for the page with its filters', () async {
      final api = _Api();

      final result = await SalaryDeductionsRepo(api).list(
        page: 2,
        status: DeductionStatus.pending,
        barberId: 10,
        month: '2026-11',
      );

      expect(api.query, {
        'page': 2,
        'size': 20,
        'status': DeductionStatus.pending,
        'barberId': 10,
        'month': '2026-11',
      });
      expect(result.getOrElse(() => throw StateError('x')).items, hasLength(2));
    });

    test('sends the decision and returns the updated row', () async {
      final api = _Api();

      final result = await SalaryDeductionsRepo(
        api,
      ).decide(1, waive: true, note: 'تجربة إعفاء');

      expect(api.decision, {'id': 1, 'waive': true, 'note': 'تجربة إعفاء'});
      expect(
        result.getOrElse(() => throw StateError('x')).status,
        DeductionStatus.waived,
      );
    });
  });
}
