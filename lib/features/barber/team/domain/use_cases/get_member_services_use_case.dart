import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../../services/domain/entities/barber_service.dart';
import '../repos/i_barber_team_services_repo.dart';

class GetMemberServicesUseCase {
  final IBarberTeamServicesRepo _repo;

  GetMemberServicesUseCase(this._repo);

  Future<Either<Failure, List<BarberService>>> call(int memberId) =>
      _repo.getServices(memberId);
}
