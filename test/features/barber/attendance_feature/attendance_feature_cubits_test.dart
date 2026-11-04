import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ayez_ahlaq/core/error/failure.dart';
import 'package:ayez_ahlaq/features/barber/attendance_feature/data/models/attendance_feature_requests_page_model.dart';
import 'package:ayez_ahlaq/features/barber/attendance_feature/domain/entities/attendance_feature_requests_page.dart';
import 'package:ayez_ahlaq/features/barber/attendance_feature/domain/entities/attendance_feature_status.dart';
import 'package:ayez_ahlaq/features/barber/attendance_feature/domain/repos/i_attendance_feature_repo.dart';
import 'package:ayez_ahlaq/features/barber/attendance_feature/domain/use_cases/cancel_attendance_feature_request_use_case.dart';
import 'package:ayez_ahlaq/features/barber/attendance_feature/domain/use_cases/get_attendance_feature_requests_use_case.dart';
import 'package:ayez_ahlaq/features/barber/attendance_feature/domain/use_cases/request_attendance_feature_use_case.dart';
import 'package:ayez_ahlaq/features/barber/attendance_feature/presentation/manager/attendance_feature_request_cubit.dart';
import 'package:ayez_ahlaq/features/barber/attendance_feature/presentation/manager/attendance_feature_requests_cubit.dart';
import 'package:ayez_ahlaq/features/barber/attendance_feature/presentation/manager/attendance_feature_requests_state.dart';

Map<String, dynamic> _item(int id) => {
  'id': id,
  'price': 10,
  'status': 'PENDING',
  'createdAt': '2026-11-04T08:07:45',
};

class _Repo implements IAttendanceFeatureRepo {
  Either<Failure, Unit> requestResult = const Right(unit);
  Either<Failure, Unit> cancelResult = const Right(unit);
  int requestCalls = 0;
  int? cancelledId;
  final pages = <int, Either<Failure, AttendanceFeatureRequestsPage>>{};
  final requestedPages = <int>[];

  @override
  Future<Either<Failure, Unit>> requestFeature() async {
    requestCalls++;
    return requestResult;
  }

  @override
  Future<Either<Failure, Unit>> cancelRequest(int id) async {
    cancelledId = id;
    return cancelResult;
  }

  @override
  Future<Either<Failure, AttendanceFeatureRequestsPage>> getRequests({
    required int page,
  }) async {
    requestedPages.add(page);
    return pages[page]!;
  }

  @override
  Future<Either<Failure, AttendanceFeatureStatus>> getStatus() =>
      throw UnimplementedError();
}

void main() {
  late _Repo repo;

  setUp(() => repo = _Repo());

  AttendanceFeatureRequestCubit requestCubit() => AttendanceFeatureRequestCubit(
    RequestAttendanceFeatureUseCase(repo),
    CancelAttendanceFeatureRequestUseCase(repo),
  );

  group('request and cancel', () {
    test('a request that goes through is reported and stops the busy state', () async {
      final cubit = requestCubit();

      final done = await cubit.requestFeature();

      expect(done, true);
      expect(repo.requestCalls, 1);
      expect(cubit.state.isSubmitting, false);
      expect(cubit.state.errorMessage, isNull);
    });

    test('a refused request keeps the server message', () async {
      repo.requestResult = Left(
        Failure('لديك طلب تفعيل قيد المراجعة بالفعل', 400, const {}),
      );
      final cubit = requestCubit();

      final done = await cubit.requestFeature();

      expect(done, false);
      expect(cubit.state.errorMessage, 'لديك طلب تفعيل قيد المراجعة بالفعل');
      expect(cubit.state.isSubmitting, false);
    });

    test('cancel sends the id of the pending request', () async {
      final cubit = requestCubit();

      final done = await cubit.cancelRequest(2);

      expect(done, true);
      expect(repo.cancelledId, 2);
    });

    test('cancel without an id does nothing', () async {
      final cubit = requestCubit();

      final done = await cubit.cancelRequest(null);

      expect(done, false);
      expect(repo.cancelledId, isNull);
      expect(cubit.state.isSubmitting, false);
    });

    test('a request already decided returns its message', () async {
      repo.cancelResult = Left(
        Failure('هذا الطلب تم البتّ فيه بالفعل (ملغي)', 400, const {}),
      );
      final cubit = requestCubit();

      final done = await cubit.cancelRequest(1);

      expect(done, false);
      expect(cubit.state.errorMessage, contains('البتّ'));
    });
  });

  group('request history', () {
    AttendanceFeatureRequestsCubit historyCubit() =>
        AttendanceFeatureRequestsCubit(
          GetAttendanceFeatureRequestsUseCase(repo),
        );

    test('loads the first page and knows there is more', () async {
      repo.pages[0] = Right(
        AttendanceFeatureRequestsPageModel.fromJson({
          'content': [_item(2), _item(1)],
          'page': 0,
          'totalPages': 2,
        }),
      );
      final cubit = historyCubit();

      await cubit.load();

      expect(cubit.state.status, AttendanceFeatureRequestsStatus.success);
      expect(cubit.state.requests.length, 2);
      expect(cubit.state.hasMore, true);
    });

    test('load more appends the next page and stops at the end', () async {
      repo.pages[0] = Right(
        AttendanceFeatureRequestsPageModel.fromJson({
          'content': [_item(2)],
          'page': 0,
          'totalPages': 2,
        }),
      );
      repo.pages[1] = Right(
        AttendanceFeatureRequestsPageModel.fromJson({
          'content': [_item(1)],
          'page': 1,
          'totalPages': 2,
        }),
      );
      final cubit = historyCubit();
      await cubit.load();

      await cubit.loadMore();
      await cubit.loadMore();

      expect(cubit.state.requests.map((r) => r.id), [2, 1]);
      expect(cubit.state.hasMore, false);
      expect(repo.requestedPages, [0, 1]);
    });

    test('a failed load shows the failure', () async {
      repo.pages[0] = Left(Failure('خطأ', 500, const {}));
      final cubit = historyCubit();

      await cubit.load();

      expect(cubit.state.status, AttendanceFeatureRequestsStatus.failure);
      expect(cubit.state.errorMessage, 'خطأ');
    });
  });
}
