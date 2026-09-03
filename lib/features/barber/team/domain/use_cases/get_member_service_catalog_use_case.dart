import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../../services/domain/entities/service_catalog_item.dart';
import '../repos/i_barber_team_services_repo.dart';

class GetMemberServiceCatalogUseCase {
  final IBarberTeamServicesRepo _repo;

  GetMemberServiceCatalogUseCase(this._repo);

  Future<Either<Failure, List<ServiceCatalogItem>>> call(int memberId) =>
      _repo.getCatalog(memberId);
}
