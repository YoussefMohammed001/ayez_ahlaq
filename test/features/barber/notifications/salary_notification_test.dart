import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:ayez_ahlaq/core/routes/route_paths.dart';
import 'package:ayez_ahlaq/features/barber/notifications/domain/entities/barber_notification.dart';
import 'package:ayez_ahlaq/features/barber/notifications/domain/entities/notification_kind.dart';
import 'package:ayez_ahlaq/features/barber/notifications/presentation/services/barber_notification_tap_router.dart';

BarberNotification _notification(
  String type, {
  String? referenceType,
  String? referenceId = '55',
}) => BarberNotification(
  id: 812,
  type: type,
  referenceType: referenceType,
  referenceId: referenceId,
  title: 't',
  body: 'b',
  createdAt: DateTime(2026, 11, 8),
);

Widget _app(BarberNotificationTapRouter router, BarberNotification item) {
  final goRouter = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, _) => Scaffold(
          body: TextButton(
            onPressed: () => router.handle(context, item),
            child: const Text('tap'),
          ),
        ),
      ),
      GoRoute(
        path: Routes.barberSalaryDeductionsScreen,
        builder: (_, __) => const Scaffold(body: Text('deductions screen')),
      ),
      GoRoute(
        path: Routes.barberMySalaryScreen,
        builder: (_, __) => const Scaffold(body: Text('my salary screen')),
      ),
      GoRoute(
        path: Routes.barberAttendanceTeamScreen,
        builder: (_, __) => const Scaffold(body: Text('team attendance')),
      ),
      GoRoute(
        path: Routes.barberAttendanceScreen,
        builder: (_, __) => const Scaffold(body: Text('my attendance')),
      ),
    ],
  );
  return MaterialApp.router(routerConfig: goRouter);
}

Future<void> _tap(
  WidgetTester tester, {
  required bool owner,
  required BarberNotification notification,
}) async {
  await tester.pumpWidget(
    _app(BarberNotificationTapRouter(isOwner: () => owner), notification),
  );
  await tester.tap(find.text('tap'));
  await tester.pumpAndSettle();
}

void main() {
  group('kinds', () {
    test('every salary type is a salary deduction notification', () {
      for (final type in [
        'salary_late',
        'salary_absent',
        'salary_early_leave',
        'SALARY_LATE',
      ]) {
        expect(
          NotificationKind.fromType(type),
          NotificationKind.salaryDeduction,
          reason: type,
        );
      }
    });

    test('check in and check out keep their own kinds', () {
      expect(
        NotificationKind.fromType('attendance_check_in'),
        NotificationKind.attendanceCheckIn,
      );
      expect(
        NotificationKind.fromType('attendance_check_out'),
        NotificationKind.attendanceCheckOut,
      );
    });

    test('other attendance types are attendance, not a plain bell', () {
      for (final type in [
        'attendance_feature_approved',
        'attendance_feature_rejected',
        'attendance_auto_check_in_failed',
      ]) {
        expect(
          NotificationKind.fromType(type),
          NotificationKind.attendance,
          reason: type,
        );
      }
    });

    test('each of them has its own icon', () {
      expect({
        NotificationKind.salaryDeduction.icon,
        NotificationKind.attendance.icon,
        NotificationKind.attendanceCheckIn.icon,
        NotificationKind.attendanceCheckOut.icon,
        NotificationKind.general.icon,
      }, hasLength(5));
    });

    test('unrelated types are not captured by the new kinds', () {
      expect(
        NotificationKind.fromType('booking_requested'),
        NotificationKind.bookingRequested,
      );
      expect(
        NotificationKind.fromType('subscription_expiring'),
        NotificationKind.subscription,
      );
    });
  });

  group('tapping a salary notification', () {
    testWidgets('the real payload opens the deductions for the owner', (
      tester,
    ) async {
      await _tap(
        tester,
        owner: true,
        notification: _notification(
          'salary_late',
          referenceType: 'salary_deduction',
        ),
      );

      expect(find.text('deductions screen'), findsOneWidget);
    });

    testWidgets('a team member lands on their own salary', (tester) async {
      await _tap(
        tester,
        owner: false,
        notification: _notification(
          'salary_late',
          referenceType: 'salary_deduction',
        ),
      );

      expect(find.text('my salary screen'), findsOneWidget);
    });

    testWidgets('the type alone is enough', (tester) async {
      await _tap(
        tester,
        owner: true,
        notification: _notification('salary_absent'),
      );

      expect(find.text('deductions screen'), findsOneWidget);
    });

    testWidgets('a salary type wins over a different referenceType', (
      tester,
    ) async {
      await _tap(
        tester,
        owner: true,
        notification: _notification('salary_late', referenceType: 'barber'),
      );

      expect(find.text('deductions screen'), findsOneWidget);
    });

    testWidgets('the reference alone opens it when the type is new', (
      tester,
    ) async {
      await _tap(
        tester,
        owner: true,
        notification: _notification(
          'deduction_reminder',
          referenceType: 'salary_deduction',
        ),
      );

      expect(find.text('deductions screen'), findsOneWidget);
    });

    testWidgets('a missing reference id does not stop it', (tester) async {
      await _tap(
        tester,
        owner: true,
        notification: _notification('salary_late', referenceId: null),
      );

      expect(find.text('deductions screen'), findsOneWidget);
    });
  });

  group('attendance taps still work next to salary', () {
    testWidgets('check in opens the team attendance for the owner', (
      tester,
    ) async {
      await _tap(
        tester,
        owner: true,
        notification: _notification(
          'attendance_check_in',
          referenceType: 'attendance',
        ),
      );

      expect(find.text('team attendance'), findsOneWidget);
    });

    testWidgets('check out opens the member attendance for a member', (
      tester,
    ) async {
      await _tap(
        tester,
        owner: false,
        notification: _notification('attendance_check_out'),
      );

      expect(find.text('my attendance'), findsOneWidget);
    });
  });
}
