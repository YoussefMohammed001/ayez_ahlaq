import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../repos/i_barber_profile_repo.dart';

class ChangeBarberPasswordUseCase {
  final IBarberProfileRepo _repo;

  ChangeBarberPasswordUseCase(this._repo);

  Future<Either<Failure, Unit>> call(String currentPassword, String newPassword) =>
      _repo.changePassword(currentPassword, newPassword);
}
