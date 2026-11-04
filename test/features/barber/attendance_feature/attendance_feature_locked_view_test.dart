import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ayez_ahlaq/core/error/failure.dart';
import 'package:ayez_ahlaq/core/routes/app_routes.dart';
import 'package:ayez_ahlaq/core/theme/light_theme.dart';
import 'package:ayez_ahlaq/core/widgets/app_confirm_dialog.dart';
import 'package:ayez_ahlaq/core/widgets/primary_cta_button.dart';
import 'package:ayez_ahlaq/features/barber/attendance_feature/data/models/attendance_feature_status_model.dart';
import 'package:ayez_ahlaq/features/barber/attendance_feature/domain/entities/attendance_feature_requests_page.dart';
import 'package:ayez_ahlaq/features/barber/attendance_feature/domain/entities/attendance_feature_status.dart';
import 'package:ayez_ahlaq/features/barber/attendance_feature/domain/repos/i_attendance_feature_repo.dart';
import 'package:ayez_ahlaq/features/barber/attendance_feature/domain/use_cases/cancel_attendance_feature_request_use_case.dart';
import 'package:ayez_ahlaq/features/barber/attendance_feature/domain/use_cases/request_attendance_feature_use_case.dart';
import 'package:ayez_ahlaq/features/barber/attendance_feature/presentation/manager/attendance_feature_request_cubit.dart';
import 'package:ayez_ahlaq/features/barber/attendance_feature/presentation/widgets/attendance_feature_locked_view.dart';
import 'package:ayez_ahlaq/generated/l10n.dart';

class _Repo implements IAttendanceFeatureRepo {
  int requestCalls = 0;
  int? cancelledId;

  @override
  Future<Either<Failure, Unit>> requestFeature() async {
    requestCalls++;
    return const Right(unit);
  }

  @override
  Future<Either<Failure, Unit>> cancelRequest(int id) async {
    cancelledId = id;
    return const Right(unit);
  }

  @override
  Future<Either<Failure, AttendanceFeatureStatus>> getStatus() =>
      throw UnimplementedError();

  @override
  Future<Either<Failure, AttendanceFeatureRequestsPage>> getRequests({
    required int page,
  }) => throw UnimplementedError();
}

AttendanceFeatureStatus _feature({
  bool owner = true,
  String state = 'NONE',
  bool canRequest = true,
  num price = 10,
  Map<String, dynamic>? pending,
}) => AttendanceFeatureStatusModel.fromJson({
  'enabled': false,
  'state': state,
  'owner': owner,
  'message': 'رسالة الخادم',
  'price': price,
  'canRequest': canRequest,
  'pendingRequest': pending,
});

Widget _host(_Repo repo, AttendanceFeatureStatus feature, VoidCallback onChanged) {
  final cubit = AttendanceFeatureRequestCubit(
    RequestAttendanceFeatureUseCase(repo),
    CancelAttendanceFeatureRequestUseCase(repo),
  );

  return ScreenUtilInit(
    designSize: const Size(402, 874),
    builder: (_, __) => MaterialApp(
      navigatorKey: rootNavigatorKey,
      theme: lightTheme,
      home: Scaffold(
        body: BlocProvider.value(
          value: cubit,
          child: SingleChildScrollView(
            child: AttendanceFeatureLockedView(
              feature: feature,
              onChanged: onChanged,
            ),
          ),
        ),
      ),
    ),
  );
}

Future<void> _tall(WidgetTester tester) async {
  tester.view.physicalSize = const Size(1200, 3200);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);
}

Finder _inDialog(String label) =>
    find.descendant(of: find.byType(AppConfirmDialog), matching: find.text(label));

void main() {
  testWidgets('a team member only reads the message and has no action', (
    tester,
  ) async {
    await _tall(tester);
    await tester.pumpWidget(_host(_Repo(), _feature(owner: false, canRequest: false), () {}));

    expect(find.text(S().attendanceFeatureLockedTitle), findsOneWidget);
    expect(find.text('رسالة الخادم'), findsOneWidget);
    expect(find.byType(PrimaryCtaButton), findsNothing);
    expect(find.text(S().attendanceFeatureRequestsLink), findsNothing);
  });

  testWidgets('the owner can request after confirming', (tester) async {
    await _tall(tester);
    final repo = _Repo();
    var changed = 0;
    await tester.pumpWidget(_host(repo, _feature(), () => changed++));

    expect(find.text(S().attendanceFeaturePrice('10')), findsOneWidget);
    await tester.tap(find.byType(PrimaryCtaButton));
    await tester.pumpAndSettle();
    expect(repo.requestCalls, 0);

    await tester.tap(_inDialog(S().attendanceFeatureRequestAction));
    await tester.pumpAndSettle(const Duration(seconds: 4));

    expect(repo.requestCalls, 1);
    expect(changed, 1);
  });

  testWidgets('declining the confirmation sends nothing', (tester) async {
    await _tall(tester);
    final repo = _Repo();
    await tester.pumpWidget(_host(repo, _feature(), () {}));

    await tester.tap(find.byType(PrimaryCtaButton));
    await tester.pumpAndSettle();
    await tester.tap(_inDialog(S().cancel));
    await tester.pumpAndSettle();

    expect(repo.requestCalls, 0);
  });

  testWidgets('a price of zero is not shown', (tester) async {
    await _tall(tester);
    await tester.pumpWidget(_host(_Repo(), _feature(price: 0), () {}));

    expect(find.textContaining(S().attendanceFeaturePrice('0')), findsNothing);
    expect(find.byType(PrimaryCtaButton), findsOneWidget);
  });

  testWidgets('a pending request shows the card and hides the request button', (
    tester,
  ) async {
    await _tall(tester);
    final repo = _Repo();
    var changed = 0;
    await tester.pumpWidget(
      _host(
        repo,
        _feature(
          state: 'PENDING',
          canRequest: false,
          pending: {'id': 2, 'status': 'PENDING', 'createdAt': '2026-11-04T08:07:45'},
        ),
        () => changed++,
      ),
    );

    expect(find.text(S().attendanceFeaturePendingTitle), findsOneWidget);
    expect(find.byType(PrimaryCtaButton), findsNothing);

    await tester.tap(find.text(S().attendanceFeatureCancelAction));
    await tester.pumpAndSettle();
    await tester.tap(_inDialog(S().attendanceFeatureCancelAction));
    await tester.pumpAndSettle(const Duration(seconds: 4));

    expect(repo.cancelledId, 2);
    expect(changed, 1);
  });

  testWidgets('a pending request without an id cannot be withdrawn', (
    tester,
  ) async {
    await _tall(tester);
    await tester.pumpWidget(
      _host(
        _Repo(),
        _feature(
          state: 'PENDING',
          canRequest: false,
          pending: {'status': 'PENDING'},
        ),
        () {},
      ),
    );

    expect(find.text(S().attendanceFeaturePendingTitle), findsOneWidget);
    expect(find.text(S().attendanceFeatureCancelAction), findsNothing);
  });

  testWidgets('an expired subscription offers a renewal', (tester) async {
    await _tall(tester);
    await tester.pumpWidget(_host(_Repo(), _feature(state: 'EXPIRED'), () {}));

    expect(find.text(S().attendanceFeatureExpiredTitle), findsOneWidget);
    expect(find.text(S().attendanceFeatureRenewAction), findsOneWidget);
    expect(find.text(S().attendanceFeatureRequestAction), findsNothing);
  });

  testWidgets('an owner who cannot request still reaches the history', (
    tester,
  ) async {
    await _tall(tester);
    await tester.pumpWidget(_host(_Repo(), _feature(canRequest: false), () {}));

    expect(find.byType(PrimaryCtaButton), findsNothing);
    expect(find.text(S().attendanceFeatureRequestsLink), findsOneWidget);
  });
}
