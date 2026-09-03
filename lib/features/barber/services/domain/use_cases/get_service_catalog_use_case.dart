import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/service_catalog_item.dart';
import '../repos/i_barber_services_repo.dart';

class GetServiceCatalogUseCase {
  final IBarberServicesRepo _repo;

  GetServiceCatalogUseCase(this._repo);

  Future<Either<Failure, List<ServiceCatalogItem>>> call() => _repo.getCatalog();
}
