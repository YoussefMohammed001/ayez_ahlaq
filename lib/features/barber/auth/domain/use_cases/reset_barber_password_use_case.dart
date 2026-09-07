import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../repos/i_barber_auth_repo.dart';

class ResetBarberPasswordUseCase {
  final IBarberAuthRepo _repo;

  ResetBarberPasswordUseCase(this._repo);

  Future<Either<Failure, Unit>> call(String resetToken, String newPassword) =>
      _repo.resetPassword(resetToken, newPassword);
}
