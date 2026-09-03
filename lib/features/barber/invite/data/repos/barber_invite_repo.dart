import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
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
    return result.map(_mapInvite);
  }

  @override
  Future<Either<Failure, BarberInvite>> regenerateInvite() async {
    final result = await _api.regenerateInvite();
    return result.map(_mapInvite);
  }

  BarberInvite _mapInvite(dynamic response) {
    return BarberInviteModel.fromJson(response['data'] as Map<String, dynamic>);
  }
}
