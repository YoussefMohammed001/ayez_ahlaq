import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../repos/i_barber_team_services_repo.dart';

class DeleteMemberServiceUseCase {
  final IBarberTeamServicesRepo _repo;

  DeleteMemberServiceUseCase(this._repo);

  Future<Either<Failure, Unit>> call(int memberId, int serviceId) =>
      _repo.deleteService(memberId, serviceId);
}
