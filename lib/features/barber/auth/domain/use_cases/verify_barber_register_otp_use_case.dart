import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../repos/i_barber_auth_repo.dart';

class VerifyBarberRegisterOtpUseCase {
  final IBarberAuthRepo _repo;

  VerifyBarberRegisterOtpUseCase(this._repo);

  Future<Either<Failure, Unit>> call(String phone, String otp) =>
      _repo.verifyRegisterOtp(phone, otp);
}
