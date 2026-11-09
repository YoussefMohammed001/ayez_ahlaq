import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ayez_ahlaq/core/analytics/app_analytics.dart';
import 'package:ayez_ahlaq/core/error/failure.dart';
import 'package:ayez_ahlaq/core/network/dio/network_service.dart';
import 'package:ayez_ahlaq/features/customer/shops/data/apis/customer_shops_api.dart';
import 'package:ayez_ahlaq/features/customer/shops/data/repos/customer_shops_repo.dart';
import 'package:ayez_ahlaq/features/customer/shops/domain/use_cases/get_shops_use_case.dart';
import 'package:ayez_ahlaq/features/customer/shops/presentation/manager/customer_shops_cubit.dart';
import 'package:ayez_ahlaq/shared/location/domain/entities/device_location_result.dart';
import 'package:ayez_ahlaq/shared/location/domain/entities/geo_point.dart';
import 'package:ayez_ahlaq/shared/location/domain/entities/location_availability.dart';
import 'package:ayez_ahlaq/shared/location/domain/entities/picked_location.dart';
import 'package:ayez_ahlaq/shared/location/domain/repos/i_location_repo.dart';
import 'package:ayez_ahlaq/shared/location/domain/use_cases/get_current_location_use_case.dart';
import '../../../support/recording_analytics.dart';

class _Network implements NetworkService {
  final requests = <({String path, Map<String, dynamic>? query})>[];

  @override
  Future<Either<Failure, dynamic>> getData({
    required String endPoint,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? data,
    bool skipClientHeader = false,
  }) async {
    requests.add((path: endPoint, query: queryParameters));
    return const Right({'data': []});
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => throw UnimplementedError();
}

class _Location extends Fake implements ILocationRepo {
  GeoPoint? device = const GeoPoint(30.123456789, 31.987654321);

  @override
  Future<DeviceLocationResult> currentLocation({
    required bool requestPermission,
  }) async => DeviceLocationResult(
    device == null
        ? LocationAvailability.unavailable
        : LocationAvailability.available,
    device,
  );
}

const _picked = PickedLocation(
  latitude: 30.0444196,
  longitude: 31.2357116,
  name: 'وسط البلد',
);

void main() {
  late _Network network;
  late _Location location;

  CustomerShopsCubit build() => CustomerShopsCubit(
    GetShopsUseCase(CustomerShopsRepo(CustomerShopsApi(network))),
    GetCurrentLocationUseCase(location),
    AppAnalytics(RecordingAnalytics()),
  );

  setUp(() {
    network = _Network();
    location = _Location();
  });

  test('my location sends the device lat and lng exactly', () async {
    await build().loadShops();

    expect(network.requests.single.path, 'customer/shop');
    expect(network.requests.single.query, {
      'lat': 30.123456789,
      'lng': 31.987654321,
    });
  });

  test('another place sends the picked lat and lng, not the device', () async {
    final cubit = build();

    await cubit.chooseArea(_picked);

    expect(network.requests.single.query, {
      'lat': 30.0444196,
      'lng': 31.2357116,
    });
  });

  test('going back to my location sends the device again', () async {
    final cubit = build();
    await cubit.chooseArea(_picked);

    location.device = const GeoPoint(29.9, 31.3);
    await cubit.useMyLocation();

    expect(network.requests.last.query, {'lat': 29.9, 'lng': 31.3});
  });

  test('moving and asking again sends the new device position', () async {
    final cubit = build();
    await cubit.loadShops();

    location.device = const GeoPoint(30.5, 31.5);
    await cubit.loadShops();

    expect(network.requests.map((r) => r.query), [
      {'lat': 30.123456789, 'lng': 31.987654321},
      {'lat': 30.5, 'lng': 31.5},
    ]);
  });

  test('picking another place twice sends each one', () async {
    final cubit = build();
    await cubit.chooseArea(_picked);

    await cubit.chooseArea(
      const PickedLocation(latitude: 31.2, longitude: 29.9, name: 'الإسكندرية'),
    );

    expect(network.requests.map((r) => r.query), [
      {'lat': 30.0444196, 'lng': 31.2357116},
      {'lat': 31.2, 'lng': 29.9},
    ]);
  });

  test('without a location nothing is sent instead of an old point', () async {
    location.device = null;

    await build().loadShops();

    expect(network.requests.single.query, isNull);
  });

  test('refreshing while on another place keeps that place', () async {
    final cubit = build();
    await cubit.chooseArea(_picked);

    await cubit.loadShops();

    expect(network.requests.last.query, {'lat': 30.0444196, 'lng': 31.2357116});
  });
}
