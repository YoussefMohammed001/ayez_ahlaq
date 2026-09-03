import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/barber_invite.dart';

abstract class IBarberInviteRepo {
  Future<Either<Failure, BarberInvite>> getInvite();

  Future<Either<Failure, BarberInvite>> regenerateInvite();
}
