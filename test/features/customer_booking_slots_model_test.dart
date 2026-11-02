import 'package:flutter_test/flutter_test.dart';
import 'package:ayez_ahlaq/features/customer/booking/data/models/booking_slots_model.dart';

void main() {
  test('parses per-barber windows and their fit flag', () {
    final model = BookingSlotsModel.fromJson({
      'date': '2026-11-03',
      'serviceTypeId': 1,
      'perBarber': [
        {
          'barberId': 2000001,
          'barberName': 'Barber 1',
          'durationMinutes': 20,
          'slots': ['11:00', '11:20', '11:40'],
          'windows': [
            {'from': '10:30', 'to': '10:40', 'minutes': 10, 'fits': false},
            {'from': '11:00', 'to': '20:00', 'minutes': 540, 'fits': true},
          ],
        },
      ],
      'anyBarberSlots': ['11:00'],
    });

    final barber = model.perBarber.single;

    expect(barber.windows, hasLength(2));
    expect(barber.windows.first.fits, false);
    expect(barber.windows.first.minutes, 10);
    expect(barber.windows.last.from, '11:00');
    expect(barber.windows.last.fits, true);
  });

  test('a response without windows still parses', () {
    final model = BookingSlotsModel.fromJson({
      'date': '2026-11-03',
      'serviceTypeId': 1,
      'perBarber': [
        {
          'barberId': 1,
          'barberName': 'x',
          'durationMinutes': 30,
          'slots': ['10:00:00'],
        },
      ],
      'anyBarberSlots': [],
    });

    expect(model.perBarber.single.windows, isEmpty);
    expect(model.perBarber.single.slots, ['10:00:00']);
  });

  test('server times with seconds are kept as given', () {
    final model = BookingSlotsModel.fromJson({
      'perBarber': [
        {
          'barberId': 1,
          'slots': ['10:00:00'],
          'windows': [
            {'from': '10:00:00', 'to': '22:00:00', 'minutes': 720, 'fits': true},
          ],
        },
      ],
    });

    expect(model.perBarber.single.windows.single.to, '22:00:00');
  });
}
