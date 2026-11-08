import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ayez_ahlaq/core/analytics/app_analytics.dart';
import 'package:ayez_ahlaq/core/error/failure.dart';
import 'package:ayez_ahlaq/core/theme/light_theme.dart';
import 'package:ayez_ahlaq/features/customer/shops/domain/entities/shop.dart';
import 'package:ayez_ahlaq/features/customer/shops/domain/entities/shop_detail.dart';
import 'package:ayez_ahlaq/features/customer/shops/domain/entities/shops_area.dart';
import 'package:ayez_ahlaq/features/customer/shops/domain/repos/i_customer_shops_repo.dart';
import 'package:ayez_ahlaq/features/customer/shops/domain/use_cases/get_shops_use_case.dart';
import 'package:ayez_ahlaq/features/customer/shops/presentation/manager/customer_shops_cubit.dart';
import 'package:ayez_ahlaq/features/customer/shops/presentation/manager/customer_shops_state.dart';
import 'package:ayez_ahlaq/features/customer/shops/domain/entities/shops_browse_mode.dart';
import 'package:ayez_ahlaq/features/customer/shops/domain/entities/shops_search.dart';
import 'package:ayez_ahlaq/features/customer/shops/presentation/widgets/shops_filter_header.dart';
import 'package:ayez_ahlaq/features/customer/shops/presentation/widgets/shops_mode_pill.dart';
import 'package:ayez_ahlaq/generated/l10n.dart';
import 'package:ayez_ahlaq/shared/location/domain/entities/device_location_result.dart';
import 'package:ayez_ahlaq/shared/location/domain/entities/geo_point.dart';
import 'package:ayez_ahlaq/shared/location/domain/entities/location_availability.dart';
import 'package:ayez_ahlaq/shared/location/domain/entities/picked_location.dart';
import 'package:ayez_ahlaq/shared/location/domain/repos/i_location_repo.dart';
import 'package:ayez_ahlaq/shared/location/domain/use_cases/get_current_location_use_case.dart';
import '../../../support/recording_analytics.dart';

class _ShopsRepo extends Fake implements ICustomerShopsRepo {
  final requests = <(double?, double?)>[];
  Either<Failure, List<Shop>> result = const Right([
    Shop(id: 1, name: 'قريب', favorite: false, rating: 4, ratingCount: 3),
  ]);

  @override
  Future<Either<Failure, List<Shop>>> getShops({
    double? lat,
    double? lng,
  }) async {
    requests.add((lat, lng));
    return result;
  }

  @override
  Future<Either<Failure, ShopDetail>> getShopDetail(int shopId) =>
      throw UnimplementedError();
}

class _LocationRepo extends Fake implements ILocationRepo {
  GeoPoint? device = const GeoPoint(30.0, 31.0);

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

const _home = PickedLocation(
  latitude: 30.16,
  longitude: 31.54,
  name: 'التجمع الخامس',
  address: 'شارع التسعين',
  city: 'القاهرة',
);

void main() {
  late _ShopsRepo repo;
  late _LocationRepo location;
  late RecordingAnalytics analytics;

  CustomerShopsCubit build() => CustomerShopsCubit(
    GetShopsUseCase(repo),
    GetCurrentLocationUseCase(location),
    AppAnalytics(analytics),
  );

  setUp(() {
    repo = _ShopsRepo();
    location = _LocationRepo();
    analytics = RecordingAnalytics();
  });

  group('cubit', () {
    test('uses the device location until a place is chosen', () async {
      final cubit = build();

      await cubit.loadShops();

      expect(repo.requests, [(30.0, 31.0)]);
      expect(cubit.state.area, isNull);
      expect(cubit.state.usesDeviceLocation, isTrue);
    });

    test('a chosen place is what the server is asked about', () async {
      final cubit = build();

      await cubit.chooseArea(_home);

      expect(repo.requests.single, (30.16, 31.54));
      expect(cubit.state.area!.label, 'التجمع الخامس');
      expect(cubit.state.mode, ShopsBrowseMode.custom);
      expect(cubit.state.status, CustomerShopsStatus.success);
    });

    test(
      'distances are measured from the chosen place, not the device',
      () async {
        final cubit = build();
        repo.result = const Right([
          Shop(
            id: 7,
            name: 'قرب البيت',
            favorite: false,
            rating: 5,
            ratingCount: 1,
            latitude: 30.16,
            longitude: 31.54,
          ),
        ]);

        await cubit.chooseArea(_home);

        expect(cubit.state.shops.single.distanceKm, closeTo(0, 0.01));
      },
    );

    test('the chosen place sticks through a refresh', () async {
      final cubit = build();
      await cubit.chooseArea(_home);

      await cubit.loadShops();

      expect(repo.requests.last, (30.16, 31.54));
    });

    test('going back uses the device location again', () async {
      final cubit = build();
      await cubit.chooseArea(_home);

      await cubit.useMyLocation();

      expect(repo.requests.last, (30.0, 31.0));
      expect(cubit.state.area, isNull);
    });

    test('going back when already on the device does nothing', () async {
      final cubit = build();
      await cubit.loadShops();

      await cubit.useMyLocation();

      expect(repo.requests, hasLength(1));
      expect(analytics.events, isEmpty);
    });

    test('a chosen place works even when the device location is off', () async {
      location.device = null;
      final cubit = build();

      await cubit.chooseArea(_home);

      expect(repo.requests.single, (30.16, 31.54));
      expect(cubit.state.sortedByDistance, isTrue);
    });

    test(
      'a failure keeps the chosen place so retrying hits the same spot',
      () async {
        repo.result = Left(Failure('offline', null, const {}));
        final cubit = build();

        await cubit.chooseArea(_home);

        expect(cubit.state.status, CustomerShopsStatus.failure);
        expect(cubit.state.area, isNotNull);
      },
    );

    test('changes of place are reported', () async {
      final cubit = build();

      await cubit.chooseArea(_home);
      await cubit.useMyLocation();

      expect(analytics.events.map((e) => e.parameters), [
        {'source': 'custom'},
        {'source': 'device'},
      ]);
      expect(analytics.names, ['shops_area_changed', 'shops_area_changed']);
    });
  });

  group('area', () {
    test('is named after the place, falling back to address then city', () {
      expect(ShopsArea.fromPicked(_home).label, 'التجمع الخامس');
      expect(
        ShopsArea.fromPicked(
          const PickedLocation(
            latitude: 1,
            longitude: 2,
            address: 'عنوان',
            city: 'مدينة',
          ),
        ).label,
        'عنوان',
      );
      expect(
        ShopsArea.fromPicked(
          const PickedLocation(latitude: 1, longitude: 2, city: 'مدينة'),
        ).label,
        'مدينة',
      );
    });
  });

  group('search', () {
    const shops = [
      Shop(
        id: 1,
        name: 'صالون النخبة',
        address: 'التجمع الخامس، القاهرة',
        favorite: false,
        rating: 4,
        ratingCount: 1,
      ),
      Shop(
        id: 2,
        name: 'Men Club',
        address: 'مدينة نصر',
        favorite: false,
        rating: 4,
        ratingCount: 1,
      ),
      Shop(
        id: 3,
        name: 'حلاق الأمير',
        address: null,
        favorite: false,
        rating: 4,
        ratingCount: 1,
      ),
    ];

    List<int> ids(String query) =>
        ShopsSearch.filter(shops, query).map((s) => s.id).toList();

    test('an empty search shows everything', () {
      expect(ids(''), [1, 2, 3]);
      expect(ids('   '), [1, 2, 3]);
    });

    test('matches the name or the address', () {
      expect(ids('النخبة'), [1]);
      expect(ids('التجمع'), [1]);
      expect(ids('نصر'), [2]);
    });

    test('ignores case and needs every word', () {
      expect(ids('men CLUB'), [2]);
      expect(ids('صالون التجمع'), [1]);
      expect(ids('صالون نصر'), isEmpty);
    });

    test('ignores Arabic spelling variants', () {
      expect(ids('الامير'), [3]);
      expect(ids('القاهره'), [1]);
    });

    test('finds nothing for an unknown word', () {
      expect(ids('مطعم'), isEmpty);
    });
  });

  group('filter header', () {
    Future<void> pump(
      WidgetTester tester, {
      ShopsBrowseMode mode = ShopsBrowseMode.device,
      String? label,
      List<String>? taps,
      TextEditingController? search,
    }) async {
      tester.view.physicalSize = const Size(804, 1748);
      tester.view.devicePixelRatio = 2;
      addTearDown(tester.view.reset);
      final log = taps ?? [];

      await tester.pumpWidget(
        ScreenUtilInit(
          designSize: const Size(402, 874),
          builder: (_, __) => MaterialApp(
            theme: lightTheme,
            home: Scaffold(
              body: ShopsFilterHeader(
                mode: mode,
                areaLabel: label,
                onMyLocation: () => log.add('device'),
                onPickPlace: () => log.add('pick'),
                searchController: search,
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
    }

    testWidgets('offers the two ways to browse with a one-line explanation', (
      tester,
    ) async {
      await pump(tester);

      expect(find.text(S().shopsAreaMyLocation), findsOneWidget);
      expect(find.text(S().shopsAreaOther), findsOneWidget);
      expect(find.text(S().shopsHintDevice), findsOneWidget);
    });

    testWidgets('each choice reports itself', (tester) async {
      final taps = <String>[];
      await pump(tester, taps: taps);

      for (final label in [S().shopsAreaMyLocation, S().shopsAreaOther]) {
        await tester.ensureVisible(find.text(label));
        await tester.tap(find.text(label));
      }

      expect(taps, ['device', 'pick']);
    });

    testWidgets(
      'the chosen place replaces the generic label and explains itself',
      (tester) async {
        await pump(
          tester,
          mode: ShopsBrowseMode.custom,
          label: 'التجمع الخامس',
        );

        expect(find.text('التجمع الخامس'), findsOneWidget);
        expect(find.text(S().shopsAreaOther), findsNothing);
        expect(find.text(S().shopsHintCustom('التجمع الخامس')), findsOneWidget);
      },
    );

    testWidgets('the two choices share the row without scrolling', (
      tester,
    ) async {
      await pump(tester);

      expect(find.byType(SingleChildScrollView), findsNothing);
      expect(
        tester.getSize(find.byType(ShopsModePill).first).width,
        tester.getSize(find.byType(ShopsModePill).last).width,
      );
    });

    testWidgets('shows a search field only when given a controller', (
      tester,
    ) async {
      await pump(tester);
      expect(find.byType(TextField), findsNothing);

      await pump(tester, search: TextEditingController());
      expect(find.text(S().shopsSearchHint), findsOneWidget);
    });
  });
}
