import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/fulfillment_type.dart';
import '../entities/store_quote.dart';
import '../repos/i_barber_store_repo.dart';

class GetQuoteUseCase {
  final IBarberStoreRepo _repo;

  GetQuoteUseCase(this._repo);

  Future<Either<Failure, StoreQuote>> call({
    required int merchantId,
    required Map<int, int> quantitiesByProductId,
    FulfillmentType? fulfillmentType,
  }) => _repo.getQuote(
    merchantId: merchantId,
    quantitiesByProductId: quantitiesByProductId,
    fulfillmentType: fulfillmentType,
  );
}
