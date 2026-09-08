import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../shared/sponsorship/sponsorship.dart';

abstract class IBarberSponsorshipRepo {
  Future<Either<Failure, Sponsorship>> getSponsorship();

  Future<Either<Failure, Sponsorship>> buySponsorship();
}
