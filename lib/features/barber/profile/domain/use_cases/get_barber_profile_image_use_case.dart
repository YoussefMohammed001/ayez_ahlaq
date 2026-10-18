import 'dart:typed_data';
import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../repos/i_barber_profile_repo.dart';

class GetBarberProfileImageUseCase {
  final IBarberProfileRepo _repo;

  GetBarberProfileImageUseCase(this._repo);

  Future<Either<Failure, Uint8List>> call() => _repo.getProfileImage();
}
