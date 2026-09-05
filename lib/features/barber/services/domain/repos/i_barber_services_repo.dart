import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/barber_service.dart';
import '../entities/own_service.dart';
import '../entities/service_catalog_item.dart';

abstract class IBarberServicesRepo {
  Future<Either<Failure, List<ServiceCatalogItem>>> getCatalog();

  Future<Either<Failure, List<BarberService>>> getServices();

  Future<Either<Failure, BarberService>> createService(BarberService service);

  Future<Either<Failure, BarberService>> updateService(BarberService service);

  Future<Either<Failure, Unit>> deleteService(int id);

  Future<Either<Failure, List<OwnService>>> getOwnServices();

  Future<Either<Failure, OwnService>> createOwnService(
    String name,
    String description,
  );

  Future<Either<Failure, Unit>> deleteOwnService(int id);
}
