import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../domain/entities/broadcast_page.dart';
import '../../domain/repos/i_barber_broadcast_repo.dart';
import '../apis/barber_broadcast_api.dart';
import '../models/broadcast_page_model.dart';

class BarberBroadcastRepo implements IBarberBroadcastRepo {
  final BarberBroadcastApi _api;

  BarberBroadcastRepo(this._api);

  @override
  Future<Either<Failure, Unit>> send({
    required String scope,
    required String title,
    required String body,
  }) async {
    final result = await _api.send(scope: scope, title: title, body: body);
    return result.map((_) => unit);
  }

  @override
  Future<Either<Failure, BroadcastPage>> list({
    required int page,
    required int size,
  }) async {
    final result = await _api.list(page: page, size: size);
    return result.map(
      (response) =>
          BroadcastPageModel.fromJson(response['data'] as Map<String, dynamic>),
    );
  }
}
