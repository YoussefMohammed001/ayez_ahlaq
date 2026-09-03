import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/cart_line.dart';
import '../entities/cart_quote.dart';
import '../entities/fulfillment_type.dart';
import '../repos/i_barber_store_repo.dart';

class QuoteCartUseCase {
  final IBarberStoreRepo _repo;

  QuoteCartUseCase(this._repo);

  Future<Either<Failure, CartQuote>> call({
    required int merchantId,
    required FulfillmentType? fulfillmentType,
    required List<CartLine> lines,
  }) => _repo.quoteCart(
    merchantId: merchantId,
    fulfillmentType: fulfillmentType,
    lines: lines,
  );
}
