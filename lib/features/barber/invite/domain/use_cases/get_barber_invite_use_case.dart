import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/barber_invite.dart';
import '../repos/i_barber_invite_repo.dart';

class GetBarberInviteUseCase {
  final IBarberInviteRepo _repo;

  GetBarberInviteUseCase(this._repo);

  Future<Either<Failure, BarberInvite>> call() => _repo.getInvite();
}
