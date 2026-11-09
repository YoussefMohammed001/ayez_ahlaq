import 'dart:async';
import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ayez_ahlaq/shared/location/data/device_position_source.dart';
import 'package:ayez_ahlaq/shared/location/data/position_gateway.dart';

final _now = DateTime(2026, 11, 9, 12);

Position _position(double lat, double lng, {DateTime? at}) => Position(
  latitude: lat,
  longitude: lng,
  timestamp: at ?? _now,
  accuracy: 5,
  altitude: 0,
  altitudeAccuracy: 0,
  heading: 0,
  headingAccuracy: 0,
  speed: 0,
  speedAccuracy: 0,
);

class _Gateway implements PositionGateway {
  Position? fresh;
  Object? freshError;
  Position? last;
  bool hang = false;
  int freshCalls = 0;

  @override
  Future<Position?> current({required Duration timeLimit}) async {
    freshCalls++;
    if (hang) return Completer<Position?>().future;
    if (freshError != null) throw freshError!;
    return fresh;
  }

  @override
  Future<Position?> lastKnown() async => last;
}

void main() {
  late _Gateway gateway;

  DevicePositionSource build() =>
      DevicePositionSource(gateway: gateway, now: () => _now);

  setUp(() => gateway = _Gateway());

  test('sends exactly the coordinates of the fresh fix', () async {
    gateway.fresh = _position(30.123456789012, 31.987654321098);

    final point = await build().resolve();

    expect(point?.latitude, 30.123456789012);
    expect(point?.longitude, 31.987654321098);
  });

  test('latitude and longitude are not swapped', () async {
    gateway.fresh = _position(30.05, 31.23);

    final point = await build().resolve();

    expect(point?.latitude, 30.05);
    expect(point?.longitude, 31.23);
  });

  test('a fresh fix wins over a last known one', () async {
    gateway
      ..fresh = _position(30.1, 31.1)
      ..last = _position(29.0, 30.0);

    final point = await build().resolve();

    expect(point?.latitude, 30.1);
  });

  test(
    'a recent last known position is used when the fresh one fails',
    () async {
      gateway
        ..freshError = TimeoutException('x')
        ..last = _position(
          30.2,
          31.2,
          at: _now.subtract(const Duration(seconds: 90)),
        );

      final point = await build().resolve();

      expect(point?.latitude, 30.2);
      expect(point?.longitude, 31.2);
    },
  );

  test(
    'an old last known position is never sent as the current place',
    () async {
      gateway
        ..freshError = TimeoutException('x')
        ..last = _position(
          30.2,
          31.2,
          at: _now.subtract(const Duration(minutes: 3)),
        );

      expect(await build().resolve(), isNull);
    },
  );

  test('no fix at all gives no location', () async {
    expect(await build().resolve(), isNull);
  });

  test('a previous answer is not reused for the next request', () async {
    final source = build();
    gateway.fresh = _position(30.1, 31.1);
    await source.resolve();

    gateway.fresh = null;

    expect(await source.resolve(), isNull);
    expect(gateway.freshCalls, 2);
  });

  test('a fix that never arrives does not block forever', () async {
    gateway.hang = true;

    final point = await build().resolve().timeout(const Duration(seconds: 15));

    expect(point, isNull);
  });
}
