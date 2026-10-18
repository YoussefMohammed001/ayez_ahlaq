import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/pending_merchant_rating.dart';

abstract class IBarberRatingsRepo {
  Future<Either<Failure, PendingMerchantRating?>> getPendingMerchantRating();

  Future<Either<Failure, Unit>> submitMerchantRating({
    required int orderId,
    required int stars,
    String? note,
  });
}
