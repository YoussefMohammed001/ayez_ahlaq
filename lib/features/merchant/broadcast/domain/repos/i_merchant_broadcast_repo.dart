import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/broadcast_page.dart';

abstract class IMerchantBroadcastRepo {
  Future<Either<Failure, Unit>> send({
    required String scope,
    required String title,
    required String body,
  });

  Future<Either<Failure, BroadcastPage>> list({
    required int page,
    required int size,
  });
}
