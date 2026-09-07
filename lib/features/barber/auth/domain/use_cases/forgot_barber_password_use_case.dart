import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../repos/i_barber_auth_repo.dart';

class ForgotBarberPasswordUseCase {
  final IBarberAuthRepo _repo;

  ForgotBarberPasswordUseCase(this._repo);

  Future<Either<Failure, Unit>> call(String phone) =>
      _repo.forgotPassword(phone);
}
