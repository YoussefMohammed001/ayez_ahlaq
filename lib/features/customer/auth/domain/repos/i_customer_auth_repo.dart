import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../shared/auth/domain/entities/auth_session.dart';
import '../../../../../shared/auth/domain/entities/password_reset_ticket.dart';
import '../../data/requests/customer_register_request.dart';

abstract class ICustomerAuthRepo {
  Future<Either<Failure, AuthSession>> login(
    String identifier,
    String password,
  );

  Future<Either<Failure, Unit>> register(CustomerRegisterRequest request);

  Future<Either<Failure, Unit>> verifyRegisterOtp(String phone, String otp);

  Future<Either<Failure, String>> resendRegisterOtp(String phone);

  Future<Either<Failure, Unit>> forgotPassword(String phone);

  Future<Either<Failure, PasswordResetTicket>> verifyPasswordOtp(
    String phone,
    String code,
  );

  Future<Either<Failure, Unit>> resetPassword(
    String resetToken,
    String newPassword,
  );

  Future<void> logout();
}
