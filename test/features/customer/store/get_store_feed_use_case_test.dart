import 'package:ayez_ahlaq/core/error/failure.dart';
import 'package:ayez_ahlaq/features/customer/shops/domain/entities/shop.dart';
import 'package:ayez_ahlaq/features/customer/shops/domain/repos/i_customer_shops_repo.dart';
import 'package:ayez_ahlaq/features/customer/shops/domain/use_cases/get_shops_use_case.dart';
import 'package:ayez_ahlaq/features/customer/store/domain/entities/shop_storefront.dart';
import 'package:ayez_ahlaq/features/customer/store/domain/repos/i_customer_store_repo.dart';
import 'package:ayez_ahlaq/features/customer/store/domain/use_cases/get_store_feed_use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';

Shop shop(int id) => Shop(
  id: id,
  name: 'shop $id',
  favorite: false,
  rating: 0,
  ratingCount: 0,
);

class FakeShopsRepo extends Fake implements ICustomerShopsRepo {
  int calls = 0;

  @override
  Future<Either<Failure, List<Shop>>> getShops({double? lat, double? lng}) {
    calls++;
    return Future.value(Right([shop(1)]));
  }
}

class FakeStoreRepo extends Fake implements ICustomerStoreRepo {
  final requestedShopIds = <int>[];

  @override
  Future<Either<Failure, ShopStorefront>> getStorefront(int shopId) {
    requestedShopIds.add(shopId);
    return Future.value(Left(Failure('no storefront', 404, {})));
  }
}

void main() {
  test('uses the shops it is given instead of requesting them again', () async {
    final shopsRepo = FakeShopsRepo();
    final storeRepo = FakeStoreRepo();
    final useCase = GetStoreFeedUseCase(GetShopsUseCase(shopsRepo), storeRepo);

    await useCase(knownShops: [shop(4), shop(5)]);

    expect(shopsRepo.calls, 0);
    expect(storeRepo.requestedShopIds, [4, 5]);
  });

  test('fetches the shops when none are known', () async {
    final shopsRepo = FakeShopsRepo();
    final storeRepo = FakeStoreRepo();
    final useCase = GetStoreFeedUseCase(GetShopsUseCase(shopsRepo), storeRepo);

    await useCase();

    expect(shopsRepo.calls, 1);
    expect(storeRepo.requestedShopIds, [1]);
  });
}
