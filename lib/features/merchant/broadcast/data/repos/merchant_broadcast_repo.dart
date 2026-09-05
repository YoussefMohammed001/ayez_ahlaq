import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../domain/repos/i_merchant_broadcast_repo.dart';
import '../apis/merchant_broadcast_api.dart';

class MerchantBroadcastRepo implements IMerchantBroadcastRepo {
  final MerchantBroadcastApi _api;

  MerchantBroadcastRepo(this._api);

  @override
  Future<Either<Failure, Unit>> send({
    required String scope,
    required String title,
    required String body,
  }) async {
    final result = await _api.send(scope: scope, title: title, body: body);
    return result.map((_) => unit);
  }
}
