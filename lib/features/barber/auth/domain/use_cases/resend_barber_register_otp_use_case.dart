import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../repos/i_barber_auth_repo.dart';

class ResendBarberRegisterOtpUseCase {
  final IBarberAuthRepo _repo;

  ResendBarberRegisterOtpUseCase(this._repo);

  Future<Either<Failure, String>> call(String phone) =>
      _repo.resendRegisterOtp(phone);
}
