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
import 'package:ayez_ahlaq/features/customer/shops/presentation/widgets/shops_area_bar.dart';
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
      expect(cubit.state.isBrowsingElsewhere, isFalse);
    });

    test('a chosen place is what the server is asked about', () async {
      final cubit = build();

      await cubit.chooseArea(_home);

      expect(repo.requests.single, (30.16, 31.54));
      expect(cubit.state.area!.label, 'التجمع الخامس');
      expect(cubit.state.isBrowsingElsewhere, isTrue);
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

  group('area bar', () {
    Future<void> pump(
      WidgetTester tester, {
      String? label,
      VoidCallback? onChange,
      VoidCallback? onBack,
    }) async {
      tester.view.physicalSize = const Size(804, 1748);
      tester.view.devicePixelRatio = 2;
      addTearDown(tester.view.reset);

      await tester.pumpWidget(
        ScreenUtilInit(
          designSize: const Size(402, 874),
          builder: (_, __) => MaterialApp(
            theme: lightTheme,
            home: Scaffold(
              body: ShopsAreaBar(
                label: label,
                onChange: onChange ?? () {},
                onUseMyLocation: onBack ?? () {},
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
    }

    testWidgets('says it is using the current location by default', (
      tester,
    ) async {
      await pump(tester);

      expect(find.text(S().shopsAreaMyLocation), findsOneWidget);
      expect(find.byTooltip(S().shopsAreaBack), findsNothing);
    });

    testWidgets('shows the chosen place and a way back', (tester) async {
      var back = 0;
      await pump(tester, label: 'التجمع الخامس', onBack: () => back++);

      expect(find.text('التجمع الخامس'), findsOneWidget);

      await tester.tap(find.byTooltip(S().shopsAreaBack));
      expect(back, 1);
    });

    testWidgets('tapping change or the bar opens the chooser', (tester) async {
      var changes = 0;
      await pump(tester, onChange: () => changes++);

      await tester.tap(find.text(S().shopsAreaChange));
      await tester.tap(find.text(S().shopsAreaTitle));

      expect(changes, 2);
    });
  });
}
