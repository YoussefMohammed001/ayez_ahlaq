import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/barber_profile.dart';
import '../repos/i_barber_profile_repo.dart';

class GetBarberProfileUseCase {
  final IBarberProfileRepo _repo;

  GetBarberProfileUseCase(this._repo);

  Future<Either<Failure, BarberProfile>> call() => _repo.getProfile();
}
