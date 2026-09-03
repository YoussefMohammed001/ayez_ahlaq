import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../../services/domain/entities/barber_service.dart';
import '../../../services/domain/entities/service_catalog_item.dart';

abstract class IBarberTeamServicesRepo {
  Future<Either<Failure, List<ServiceCatalogItem>>> getCatalog(int memberId);

  Future<Either<Failure, List<BarberService>>> getServices(int memberId);

  Future<Either<Failure, BarberService>> createService(
    int memberId,
    BarberService service,
  );

  Future<Either<Failure, BarberService>> updateService(
    int memberId,
    BarberService service,
  );

  Future<Either<Failure, Unit>> deleteService(int memberId, int serviceId);
}
