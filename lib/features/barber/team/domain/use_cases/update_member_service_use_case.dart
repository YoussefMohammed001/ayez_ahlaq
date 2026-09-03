import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../../services/domain/entities/barber_service.dart';
import '../repos/i_barber_team_services_repo.dart';

class UpdateMemberServiceUseCase {
  final IBarberTeamServicesRepo _repo;

  UpdateMemberServiceUseCase(this._repo);

  Future<Either<Failure, BarberService>> call(
    int memberId,
    BarberService service,
  ) => _repo.updateService(memberId, service);
}
