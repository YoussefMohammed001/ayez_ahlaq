import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../../profile/domain/entities/barber_permissions.dart';
import '../repos/i_barber_team_repo.dart';

class UpdateMemberPermissionsUseCase {
  final IBarberTeamRepo _repo;

  UpdateMemberPermissionsUseCase(this._repo);

  Future<Either<Failure, BarberPermissions>> call(
    int id,
    BarberPermissions permissions,
  ) => _repo.updatePermissions(id, permissions);
}
