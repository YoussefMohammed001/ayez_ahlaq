import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ayez_ahlaq/core/theme/light_theme.dart';
import 'package:ayez_ahlaq/features/barber/attendance/domain/entities/attendance_config.dart';
import 'package:ayez_ahlaq/features/barber/attendance/domain/entities/attendance_range_rules.dart';
import 'package:ayez_ahlaq/features/barber/attendance/domain/entities/attendance_settings.dart';
import 'package:ayez_ahlaq/features/barber/attendance/presentation/widgets/attendance_range_validator.dart';
import 'package:ayez_ahlaq/features/barber/attendance/presentation/widgets/attendance_settings_form.dart';
import 'package:ayez_ahlaq/generated/l10n.dart';

AttendanceSettings _settings({int? range, bool enforced = false}) =>
    AttendanceSettings(
      config: AttendanceConfig(
        shopLat: 30,
        shopLng: 31,
        rangeMeters: range,
        enforced: enforced,
      ),
      updatedByName: null,
      updatedAt: null,
    );

void main() {
  group('range rules', () {
    test('accept 150 to 5000 meters', () {
      expect(AttendanceRangeRules.isValid(149), isFalse);
      expect(AttendanceRangeRules.isValid(150), isTrue);
      expect(AttendanceRangeRules.isValid(5000), isTrue);
      expect(AttendanceRangeRules.isValid(5001), isFalse);
    });
  });

  group('validator', () {
    final relaxed = AttendanceRangeValidator.of(enforced: () => false);
    final strict = AttendanceRangeValidator.of(enforced: () => true);

    test('an empty range is fine unless attendance is enforced', () {
      expect(relaxed(''), isNull);
      expect(relaxed(null), isNull);
      expect(strict(''), S().attendanceRangeInvalid);
    });

    test('rejects anything under 150 or over 5000, enforced or not', () {
      for (final text in ['10', '149', '5001', '0', 'abc']) {
        expect(relaxed(text), S().attendanceRangeInvalid, reason: text);
        expect(strict(text), S().attendanceRangeInvalid, reason: text);
      }
    });

    test('accepts the limits and the usual values', () {
      for (final text in ['150', '200', '5000', ' 300 ']) {
        expect(relaxed(text), isNull, reason: text);
        expect(strict(text), isNull, reason: text);
      }
    });
  });

  group('settings form', () {
    Future<List<(bool, int?)>> pump(
      WidgetTester tester,
      AttendanceSettings settings,
    ) async {
      tester.view.physicalSize = const Size(804, 1748);
      tester.view.devicePixelRatio = 2;
      addTearDown(tester.view.reset);
      final saved = <(bool, int?)>[];

      await tester.pumpWidget(
        ScreenUtilInit(
          designSize: const Size(402, 874),
          builder: (_, __) => MaterialApp(
            theme: lightTheme,
            home: Scaffold(
              body: SingleChildScrollView(
                child: AttendanceSettingsForm(
                  settings: settings,
                  isSubmitting: false,
                  onSave: (enforced, range) async => saved.add((enforced, range)),
                ),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      return saved;
    }

    testWidgets('a range below 150 shows the message and is not saved', (
      tester,
    ) async {
      final saved = await pump(tester, _settings(range: 10));

      await tester.tap(find.text(S().save));
      await tester.pumpAndSettle();

      expect(find.text(S().attendanceRangeInvalid), findsOneWidget);
      expect(saved, isEmpty);
    });

    testWidgets('typing a short range shows the message as you type', (
      tester,
    ) async {
      await pump(tester, _settings());

      await tester.enterText(find.byType(TextFormField), '90');
      await tester.pumpAndSettle();

      expect(find.text(S().attendanceRangeInvalid), findsOneWidget);
    });

    testWidgets('150 is saved', (tester) async {
      final saved = await pump(tester, _settings(range: 150));

      await tester.tap(find.text(S().save));
      await tester.pumpAndSettle();

      expect(find.text(S().attendanceRangeInvalid), findsNothing);
      expect(saved, [(false, 150)]);
    });

    testWidgets('no range at all is saved when not enforced', (tester) async {
      final saved = await pump(tester, _settings());

      await tester.tap(find.text(S().save));
      await tester.pumpAndSettle();

      expect(saved, [(false, null)]);
    });
  });
}
