import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../shared/auth/domain/entities/password_reset_ticket.dart';
import '../repos/i_customer_auth_repo.dart';

class VerifyCustomerPasswordOtpUseCase {
  final ICustomerAuthRepo _repo;

  VerifyCustomerPasswordOtpUseCase(this._repo);

  Future<Either<Failure, PasswordResetTicket>> call(
    String phone,
    String code,
  ) => _repo.verifyPasswordOtp(phone, code);
}
