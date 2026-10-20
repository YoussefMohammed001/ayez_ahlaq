import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../../shops/domain/entities/shop.dart';
import '../../../shops/domain/use_cases/get_shops_use_case.dart';
import '../entities/store_feed_product.dart';
import '../repos/i_customer_store_repo.dart';

class GetStoreFeedUseCase {
  final GetShopsUseCase _getShops;
  final ICustomerStoreRepo _storeRepo;

  GetStoreFeedUseCase(this._getShops, this._storeRepo);

  Future<Either<Failure, List<StoreFeedProduct>>> call({
    List<Shop>? knownShops,
  }) async {
    var shops = knownShops ?? const <Shop>[];
    if (knownShops == null) {
      Failure? failure;
      (await _getShops()).fold((f) => failure = f, (s) => shops = s);
      if (failure != null) return Left(failure!);
    }

    final storefronts = await Future.wait(shops.map(_fetchShopProducts));
    return Right(storefronts.expand((items) => items).toList());
  }

  Future<List<StoreFeedProduct>> _fetchShopProducts(Shop shop) async {
    final result = await _storeRepo.getStorefront(shop.id);
    return result.fold(
      (_) => const [],
      (storefront) => storefront.products
          .map((product) => StoreFeedProduct(
                product: product,
                shopId: shop.id,
                shopName: shop.name,
              ))
          .toList(),
    );
  }
}
