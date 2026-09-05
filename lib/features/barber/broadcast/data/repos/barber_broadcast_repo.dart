import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../domain/repos/i_barber_broadcast_repo.dart';
import '../apis/barber_broadcast_api.dart';

class BarberBroadcastRepo implements IBarberBroadcastRepo {
  final BarberBroadcastApi _api;

  BarberBroadcastRepo(this._api);

  @override
  Future<Either<Failure, Unit>> send({
    required String title,
    required String body,
  }) async {
    final result = await _api.send(title: title, body: body);
    return result.map((_) => unit);
  }
}
