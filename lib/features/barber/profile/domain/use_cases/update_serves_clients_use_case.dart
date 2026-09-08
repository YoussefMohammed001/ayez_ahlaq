import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/barber_profile.dart';
import '../repos/i_barber_profile_repo.dart';

class UpdateServesClientsUseCase {
  final IBarberProfileRepo _repo;

  UpdateServesClientsUseCase(this._repo);

  Future<Either<Failure, BarberProfile>> call(bool value) =>
      _repo.updateServesClients(value);
}
