import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../shared/sponsorship/sponsorship.dart';
import '../repos/i_barber_sponsorship_repo.dart';

class GetBarberSponsorshipUseCase {
  final IBarberSponsorshipRepo _repo;

  GetBarberSponsorshipUseCase(this._repo);

  Future<Either<Failure, Sponsorship>> call() => _repo.getSponsorship();
}
