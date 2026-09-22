import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/network/response_guard.dart';
import '../../domain/entities/barber_invite.dart';
import '../../domain/repos/i_barber_invite_repo.dart';
import '../apis/barber_invite_api.dart';
import '../models/barber_invite_model.dart';

class BarberInviteRepo implements IBarberInviteRepo {
  final BarberInviteApi _api;

  BarberInviteRepo(this._api);

  @override
  Future<Either<Failure, BarberInvite>> getInvite() async {
    final result = await _api.getInvite();
    return result.flatMap(_mapInvite);
  }

  @override
  Future<Either<Failure, BarberInvite>> regenerateInvite() async {
    final result = await _api.regenerateInvite();
    return result.flatMap(_mapInvite);
  }

  Either<Failure, BarberInvite> _mapInvite(dynamic response) {
    return requireDataMap(response).map(BarberInviteModel.fromJson);
  }
}
