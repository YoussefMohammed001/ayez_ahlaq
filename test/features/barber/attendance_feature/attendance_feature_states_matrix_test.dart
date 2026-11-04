import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ayez_ahlaq/core/routes/app_routes.dart';
import 'package:ayez_ahlaq/core/theme/light_theme.dart';
import 'package:ayez_ahlaq/core/widgets/primary_cta_button.dart';
import 'package:ayez_ahlaq/features/barber/attendance_feature/data/models/attendance_feature_status_model.dart';
import 'package:ayez_ahlaq/features/barber/attendance_feature/domain/entities/attendance_feature_state.dart';
import 'package:ayez_ahlaq/features/barber/attendance_feature/domain/use_cases/cancel_attendance_feature_request_use_case.dart';
import 'package:ayez_ahlaq/features/barber/attendance_feature/domain/use_cases/request_attendance_feature_use_case.dart';
import 'package:ayez_ahlaq/features/barber/attendance_feature/presentation/manager/attendance_feature_request_cubit.dart';
import 'package:ayez_ahlaq/features/barber/attendance_feature/presentation/widgets/attendance_feature_locked_view.dart';
import 'package:ayez_ahlaq/generated/l10n.dart';
import 'attendance_feature_locked_view_test.dart' show FakeFeatureRepo;

const _states = [
  'NONE',
  'PENDING',
  'EXPIRED',
  'SUSPENDED',
  'DEACTIVATED',
  'CANCELLED',
  'ENDED',
  'SOMETHING_NEW',
  '',
];

Widget _host(Map<String, dynamic> json) {
  final repo = FakeFeatureRepo();
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
              feature: AttendanceFeatureStatusModel.fromJson(json),
              onChanged: () {},
            ),
          ),
        ),
      ),
    ),
  );
}

void main() {
  test('every way the backend may name a stopped subscription is understood', () {
    expect(AttendanceFeatureState.fromApi('EXPIRED'), AttendanceFeatureState.expired);
    expect(AttendanceFeatureState.fromApi('ended'), AttendanceFeatureState.expired);
    for (final name in ['SUSPENDED', 'DEACTIVATED', 'PAUSED', 'STOPPED', 'TERMINATED', 'CANCELLED', 'canceled']) {
      expect(AttendanceFeatureState.fromApi(name), AttendanceFeatureState.suspended, reason: name);
    }
    expect(AttendanceFeatureState.fromApi(null), AttendanceFeatureState.unknown);
  });

  for (final state in _states) {
    for (final canRequest in [true, false]) {
      for (final owner in [true, false]) {
        testWidgets('state "$state", canRequest $canRequest, owner $owner', (
          tester,
        ) async {
          tester.view.physicalSize = const Size(1200, 3200);
          tester.view.devicePixelRatio = 1;
          addTearDown(tester.view.reset);

          await tester.pumpWidget(
            _host({
              'enabled': false,
              'state': state,
              'owner': owner,
              'message': null,
              'price': 10,
              'canRequest': canRequest,
              'pendingRequest': null,
            }),
          );

          final pending = state == 'PENDING';
          final showsRequestButton = owner && canRequest && !pending;

          expect(
            find.byType(PrimaryCtaButton),
            showsRequestButton ? findsOneWidget : findsNothing,
          );
          expect(find.byIcon(Icons.lock_outline_rounded), findsOneWidget);
          expect(
            find.text(
              owner
                  ? S().attendanceFeatureOwnerFallback
                  : S().attendanceFeatureMemberFallback,
            ),
            findsOneWidget,
          );
          expect(
            find.text(S().attendanceFeatureRequestsLink),
            owner ? findsOneWidget : findsNothing,
          );
        });
      }
    }
  }

  testWidgets('a suspended subscription says it was stopped', (tester) async {
    tester.view.physicalSize = const Size(1200, 3200);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(
      _host({'enabled': false, 'state': 'SUSPENDED', 'owner': true, 'canRequest': true, 'price': 10}),
    );

    expect(find.text(S().attendanceFeatureSuspendedTitle), findsOneWidget);
    expect(find.text(S().attendanceFeatureRequestAction), findsOneWidget);
  });
}
