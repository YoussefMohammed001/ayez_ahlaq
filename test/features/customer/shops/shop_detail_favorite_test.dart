import 'dart:async';

import 'package:ayez_ahlaq/core/analytics/i_analytics_service.dart';
import 'package:ayez_ahlaq/core/error/failure.dart';
import 'package:ayez_ahlaq/features/customer/favorites/domain/repos/i_customer_favorites_repo.dart';
import 'package:ayez_ahlaq/features/customer/favorites/domain/use_cases/add_favorite_use_case.dart';
import 'package:ayez_ahlaq/features/customer/favorites/domain/use_cases/remove_favorite_use_case.dart';
import 'package:ayez_ahlaq/features/customer/shops/domain/entities/shop.dart';
import 'package:ayez_ahlaq/features/customer/shops/domain/entities/shop_barber.dart';
import 'package:ayez_ahlaq/features/customer/shops/domain/entities/shop_detail.dart';
import 'package:ayez_ahlaq/features/customer/shops/domain/repos/i_customer_shops_repo.dart';
import 'package:ayez_ahlaq/features/customer/shops/domain/use_cases/get_shop_detail_use_case.dart';
import 'package:ayez_ahlaq/features/customer/shops/presentation/manager/customer_shop_detail_cubit.dart';
import 'package:ayez_ahlaq/shared/location/domain/use_cases/open_in_maps_use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';

ShopBarber barber(int id, {bool favorite = false}) => ShopBarber(
  id: id,
  name: 'barber $id',
  rating: 0,
  ratingCount: 0,
  available: true,
  favorite: favorite,
  viaInvite: false,
  owner: false,
  services: const [],
);

class FakeShopsRepo extends Fake implements ICustomerShopsRepo {
  @override
  Future<Either<Failure, ShopDetail>> getShopDetail(int shopId) =>
      Future.value(
        Right(
          ShopDetail(
            shop: const Shop(
              id: 1,
              name: 'shop',
              favorite: false,
              rating: 0,
              ratingCount: 0,
            ),
            barbers: [barber(1), barber(2)],
            haircutStyles: const [],
            paymentMethods: const [],
            addons: const [],
          ),
        ),
      );
}

class FakeFavoritesRepo extends Fake implements ICustomerFavoritesRepo {
  final addCalls = <int>[];
  final release = Completer<Either<Failure, Unit>>();

  @override
  Future<Either<Failure, Unit>> addFavorite(int barberId) {
    addCalls.add(barberId);
    return release.future;
  }
}

class FakeMaps extends Fake implements OpenInMapsUseCase {}

class FakeAnalytics extends Fake implements IAnalyticsService {}

Future<(CustomerShopDetailCubit, FakeFavoritesRepo)> loadedCubit() async {
  final favorites = FakeFavoritesRepo();
  final cubit = CustomerShopDetailCubit(
    GetShopDetailUseCase(FakeShopsRepo()),
    AddFavoriteUseCase(favorites),
    RemoveFavoriteUseCase(favorites),
    FakeMaps(),
    FakeAnalytics(),
  );
  await cubit.loadShopDetail(1);
  return (cubit, favorites);
}

void main() {
  test('a second tap while the first is in flight sends nothing', () async {
    final (cubit, favorites) = await loadedCubit();

    final first = cubit.toggleFavorite(1);
    final second = await cubit.toggleFavorite(1);
    favorites.release.complete(const Right(unit));

    expect(second, isFalse);
    expect(await first, isTrue);
    expect(favorites.addCalls, [1]);
    expect(cubit.state.detail!.barbers.first.favorite, isTrue);
  });

  test('a failed toggle rolls back only that barber', () async {
    final (cubit, favorites) = await loadedCubit();

    final pending = cubit.toggleFavorite(1);
    favorites.release.complete(Left(Failure('offline', 500, {})));

    expect(await pending, isFalse);
    expect(cubit.state.detail!.barbers.first.favorite, isFalse);
    expect(cubit.state.errorMessage, 'offline');
  });
}
