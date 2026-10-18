import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../repos/i_barber_profile_repo.dart';

class UploadBarberProfileImageUseCase {
  final IBarberProfileRepo _repo;

  UploadBarberProfileImageUseCase(this._repo);

  Future<Either<Failure, Unit>> call(String filePath) =>
      _repo.uploadProfileImage(filePath);
}
