import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:ayez_ahlaq/core/routes/route_paths.dart';
import 'package:ayez_ahlaq/features/barber/notifications/domain/entities/barber_notification.dart';
import 'package:ayez_ahlaq/features/barber/notifications/domain/entities/notification_kind.dart';
import 'package:ayez_ahlaq/features/barber/notifications/presentation/services/barber_notification_tap_router.dart';

BarberNotification _notification(String type, {String? referenceType}) =>
    BarberNotification(
      id: 1,
      type: type,
      referenceType: referenceType,
      referenceId: '14',
      title: 't',
      body: 'b',
      createdAt: DateTime(2026, 11, 3),
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
        path: Routes.barberAttendanceTeamScreen,
        builder: (_, __) => const Scaffold(body: Text('team screen')),
      ),
      GoRoute(
        path: Routes.barberAttendanceScreen,
        builder: (_, __) => const Scaffold(body: Text('my attendance screen')),
      ),
    ],
  );
  return MaterialApp.router(routerConfig: goRouter);
}

void main() {
  group('NotificationKind', () {
    test('attendance check in and check out are their own kinds', () {
      expect(
        NotificationKind.fromType('attendance_check_in'),
        NotificationKind.attendanceCheckIn,
      );
      expect(
        NotificationKind.fromType('attendance_check_out'),
        NotificationKind.attendanceCheckOut,
      );
    });

    test('the two kinds have different icons and are not general', () {
      expect(
        NotificationKind.attendanceCheckIn.icon,
        isNot(NotificationKind.attendanceCheckOut.icon),
      );
      expect(
        NotificationKind.attendanceCheckIn.icon,
        isNot(NotificationKind.general.icon),
      );
    });

    test('other types keep their kind', () {
      expect(
        NotificationKind.fromType('booking_requested'),
        NotificationKind.bookingRequested,
      );
      expect(
        NotificationKind.fromType('something_new'),
        NotificationKind.general,
      );
    });
  });

  group('tapping an attendance notification', () {
    testWidgets('the owner lands on the team attendance screen', (
      tester,
    ) async {
      await tester.pumpWidget(
        _app(
          BarberNotificationTapRouter(isOwner: () => true),
          _notification('attendance_check_in'),
        ),
      );

      await tester.tap(find.text('tap'));
      await tester.pumpAndSettle();

      expect(find.text('team screen'), findsOneWidget);
    });

    testWidgets('a team member lands on their own attendance screen', (
      tester,
    ) async {
      await tester.pumpWidget(
        _app(
          BarberNotificationTapRouter(isOwner: () => false),
          _notification('attendance_check_out'),
        ),
      );

      await tester.tap(find.text('tap'));
      await tester.pumpAndSettle();

      expect(find.text('my attendance screen'), findsOneWidget);
    });

    testWidgets('an unexpected referenceType does not stop the navigation', (
      tester,
    ) async {
      await tester.pumpWidget(
        _app(
          BarberNotificationTapRouter(isOwner: () => true),
          _notification('attendance_check_in', referenceType: 'barber'),
        ),
      );

      await tester.tap(find.text('tap'));
      await tester.pumpAndSettle();

      expect(find.text('team screen'), findsOneWidget);
    });

    testWidgets(
      'a feature notification opens the attendance screen for the owner',
      (tester) async {
        await tester.pumpWidget(
          _app(
            BarberNotificationTapRouter(isOwner: () => true),
            _notification('attendance_feature_approved'),
          ),
        );

        await tester.tap(find.text('tap'));
        await tester.pumpAndSettle();

        expect(find.text('my attendance screen'), findsOneWidget);
      },
    );
  });
}
