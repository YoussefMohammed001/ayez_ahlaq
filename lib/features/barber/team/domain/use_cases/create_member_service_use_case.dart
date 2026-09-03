import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../../services/domain/entities/barber_service.dart';
import '../repos/i_barber_team_services_repo.dart';

class CreateMemberServiceUseCase {
  final IBarberTeamServicesRepo _repo;

  CreateMemberServiceUseCase(this._repo);

  Future<Either<Failure, BarberService>> call(
    int memberId,
    BarberService service,
  ) => _repo.createService(memberId, service);
}
