import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../repos/i_barber_profile_repo.dart';

class DeleteBarberProfileImageUseCase {
  final IBarberProfileRepo _repo;

  DeleteBarberProfileImageUseCase(this._repo);

  Future<Either<Failure, Unit>> call() => _repo.deleteProfileImage();
}
