import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../shared/auth/domain/entities/password_reset_ticket.dart';
import '../repos/i_barber_auth_repo.dart';

class VerifyBarberPasswordOtpUseCase {
  final IBarberAuthRepo _repo;

  VerifyBarberPasswordOtpUseCase(this._repo);

  Future<Either<Failure, PasswordResetTicket>> call(
    String phone,
    String code,
  ) => _repo.verifyPasswordOtp(phone, code);
}
