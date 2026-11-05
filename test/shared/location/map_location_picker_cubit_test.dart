import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ayez_ahlaq/core/error/failure.dart';
import 'package:ayez_ahlaq/shared/location/domain/entities/device_location_result.dart';
import 'package:ayez_ahlaq/shared/location/domain/entities/geo_point.dart';
import 'package:ayez_ahlaq/shared/location/domain/entities/location_availability.dart';
import 'package:ayez_ahlaq/shared/location/domain/entities/place_info.dart';
import 'package:ayez_ahlaq/shared/location/domain/entities/place_suggestion.dart';
import 'package:ayez_ahlaq/shared/location/domain/repos/i_location_repo.dart';
import 'package:ayez_ahlaq/shared/location/domain/use_cases/get_current_location_use_case.dart';
import 'package:ayez_ahlaq/shared/location/domain/use_cases/resolve_place_use_case.dart';
import 'package:ayez_ahlaq/shared/location/domain/use_cases/search_places_use_case.dart';
import 'package:ayez_ahlaq/shared/location/presentation/manager/map_location_picker_cubit.dart';

class _Repo implements ILocationRepo {
  final pending = <GeoPoint, Completer<Either<Failure, PlaceInfo>>>{};
  Either<Failure, PlaceInfo> defaultPlace = const Right(
    PlaceInfo(name: 'شارع التحرير', city: 'القاهرة', fullAddress: 'شارع التحرير، الدقي'),
  );
  List<PlaceSuggestion> suggestions = const [];

  @override
  Future<Either<Failure, PlaceInfo>> placeOf(GeoPoint point) {
    final completer = pending[point];
    if (completer != null) return completer.future;
    return Future.value(defaultPlace);
  }

  @override
  Future<Either<Failure, List<PlaceSuggestion>>> search(String query) async =>
      Right(suggestions);

  @override
  Future<DeviceLocationResult> currentLocation({
    required bool requestPermission,
  }) async => const DeviceLocationResult(LocationAvailability.unavailable);

  @override
  dynamic noSuchMethod(Invocation invocation) => throw UnimplementedError();
}

void main() {
  late _Repo repo;

  MapLocationPickerCubit build() => MapLocationPickerCubit(
    GetCurrentLocationUseCase(repo),
    ResolvePlaceUseCase(repo),
    SearchPlacesUseCase(repo),
  );

  setUp(() => repo = _Repo());

  test('moving the map blocks the confirmation until the address is known', () async {
    final cubit = build();

    cubit.onCameraMove();

    expect(cubit.state.isMoving, true);
    expect(cubit.canConfirm, false);

    await cubit.onCameraIdle(const GeoPoint(30.05, 31.23));

    expect(cubit.state.isMoving, false);
    expect(cubit.state.isResolvingPlace, false);
    expect(cubit.canConfirm, true);
    expect(cubit.state.place.fullAddress, 'شارع التحرير، الدقي');
  });

  test('the confirmation waits while the address is being resolved', () async {
    const target = GeoPoint(30.05, 31.23);
    repo.pending[target] = Completer();
    final cubit = build();

    final resolving = cubit.onCameraIdle(target);

    expect(cubit.state.isResolvingPlace, true);
    expect(cubit.canConfirm, false);

    repo.pending[target]!.complete(const Right(PlaceInfo(name: 'x')));
    await resolving;

    expect(cubit.canConfirm, true);
  });

  test('an address that arrives after the map moved again is ignored', () async {
    const first = GeoPoint(30.0, 31.0);
    const second = GeoPoint(30.1, 31.1);
    repo.pending[first] = Completer();
    final cubit = build();

    final slow = cubit.onCameraIdle(first);
    cubit.onCameraMove();
    await cubit.onCameraIdle(second);
    repo.pending[first]!.complete(const Right(PlaceInfo(name: 'قديم')));
    await slow;

    expect(cubit.state.place.name, 'شارع التحرير');
    expect(cubit.state.target, second);
  });

  test('moving the map while an address is loading drops that address', () async {
    const target = GeoPoint(30.0, 31.0);
    repo.pending[target] = Completer();
    final cubit = build();

    final resolving = cubit.onCameraIdle(target);
    cubit.onCameraMove();
    repo.pending[target]!.complete(const Right(PlaceInfo(name: 'قديم')));
    await resolving;

    expect(cubit.state.isMoving, true);
    expect(cubit.state.place.name, isNot('قديم'));
    expect(cubit.canConfirm, false);
  });

  test('a failed address lookup still lets the user confirm the pin', () async {
    repo.defaultPlace = Left(Failure('تعذّر', 500, const {}));
    final cubit = build();

    await cubit.onCameraIdle(const GeoPoint(30.05, 31.23));

    expect(cubit.canConfirm, true);
    expect(cubit.state.place.isEmpty, true);
    expect(cubit.picked.latitude, 30.05);
    expect(cubit.picked.address, '');
  });

  test('the confirmed location carries the pin and the address', () async {
    final cubit = build();

    await cubit.onCameraIdle(const GeoPoint(30.05, 31.23));
    final picked = cubit.picked;

    expect(picked.latitude, 30.05);
    expect(picked.longitude, 31.23);
    expect(picked.address, 'شارع التحرير، الدقي');
    expect(picked.city, 'القاهرة');
  });

  test('a search with no result keeps the pin and reports it', () async {
    final cubit = build();
    await cubit.onCameraIdle(const GeoPoint(30.05, 31.23));

    final found = await cubit.searchAndSelect('مكان غير موجود');

    expect(found, isNull);
    expect(cubit.state.errorMessage, isNotNull);
    expect(cubit.state.target, const GeoPoint(30.05, 31.23));
  });
}
