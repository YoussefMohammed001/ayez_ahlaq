import 'package:flutter_test/flutter_test.dart';
import 'package:ayez_ahlaq/features/barber/hours/domain/entities/working_day.dart';
import 'package:ayez_ahlaq/features/barber/hours/domain/entities/working_week.dart';

WorkingDay day(String open, String close, {bool isOpen = true, int dow = 0}) =>
    WorkingDay(
      dayOfWeek: dow,
      isOpen: isOpen,
      openTime: open,
      closeTime: close,
    );

void main() {
  test('same-day range is not next day and has its duration', () {
    final value = day('10:00', '22:00');

    expect(value.closesNextDay, false);
    expect(value.durationMinutes, 12 * 60);
  });

  test('noon to 1 AM closes the next day', () {
    final value = day('12:00', '01:00');

    expect(value.closesNextDay, true);
    expect(value.durationMinutes, 13 * 60);
  });

  test('noon to midnight is 12 hours', () {
    final value = day('12:00', '00:00');

    expect(value.closesNextDay, true);
    expect(value.durationMinutes, 12 * 60);
  });

  test('server times with seconds are parsed', () {
    expect(day('10:00:00', '22:30:00').durationMinutes, 12 * 60 + 30);
  });

  test('same open and close is invalid only for open days', () {
    expect([day('10:00', '10:00')].isValid, false);
    expect([day('10:00', '10:00', isOpen: false)].isValid, true);
    expect([day('12:00', '01:00')].isValid, true);
  });
}
