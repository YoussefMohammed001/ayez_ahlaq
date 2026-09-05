import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/store_fulfillment_type.dart';
import '../entities/store_quote.dart';
import '../repos/i_customer_store_repo.dart';

class QuoteStoreCartUseCase {
  final ICustomerStoreRepo _repo;

  QuoteStoreCartUseCase(this._repo);

  Future<Either<Failure, StoreQuote>> call({
    required int shopId,
    required StoreFulfillmentType fulfillmentType,
    required Map<int, int> items,
  }) => _repo.quoteCart(shopId: shopId, fulfillmentType: fulfillmentType, items: items);
}
