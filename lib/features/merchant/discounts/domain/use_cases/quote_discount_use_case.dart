import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/discount_quote.dart';
import '../repos/i_merchant_discounts_repo.dart';

class QuoteDiscountUseCase {
  final IMerchantDiscountsRepo _repo;

  QuoteDiscountUseCase(this._repo);

  Future<Either<Failure, DiscountQuote>> call({
    int? shopId,
    required Map<int, int> items,
  }) => _repo.quote(shopId: shopId, items: items);
}
