import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../repos/i_merchant_broadcast_repo.dart';

class SendMerchantBroadcastUseCase {
  final IMerchantBroadcastRepo _repo;

  SendMerchantBroadcastUseCase(this._repo);

  Future<Either<Failure, Unit>> call({
    required String scope,
    required String title,
    required String body,
  }) {
    return _repo.send(scope: scope, title: title, body: body);
  }
}
