import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../domain/entities/barber_service.dart';
import '../../domain/entities/service_catalog_item.dart';
import '../../domain/repos/i_barber_services_repo.dart';
import '../apis/barber_services_api.dart';
import '../models/barber_service_model.dart';
import '../models/service_catalog_item_model.dart';

class BarberServicesRepo implements IBarberServicesRepo {
  final BarberServicesApi _api;

  BarberServicesRepo(this._api);

  @override
  Future<Either<Failure, List<ServiceCatalogItem>>> getCatalog() async {
    final result = await _api.getCatalog();
    return result.map(_mapCatalog);
  }

  @override
  Future<Either<Failure, List<BarberService>>> getServices() async {
    final result = await _api.getServices();
    return result.map(_mapServices);
  }

  @override
  Future<Either<Failure, BarberService>> createService(
    BarberService service,
  ) async {
    final result = await _api.createService(
      BarberServiceModel.toCreateJson(service),
    );
    return result.map(_mapOne);
  }

  @override
  Future<Either<Failure, BarberService>> updateService(
    BarberService service,
  ) async {
    final result = await _api.updateService(
      service.id,
      BarberServiceModel.toUpdateJson(service),
    );
    return result.map(_mapOne);
  }

  @override
  Future<Either<Failure, Unit>> deleteService(int id) async {
    final result = await _api.deleteService(id);
    return result.map((_) => unit);
  }

  List<ServiceCatalogItem> _mapCatalog(dynamic response) {
    final data = response['data'] as List? ?? const [];
    return data
        .map((json) => ServiceCatalogItemModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  List<BarberService> _mapServices(dynamic response) {
    final data = response['data'] as List? ?? const [];
    return data
        .map((json) => BarberServiceModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  BarberService _mapOne(dynamic response) {
    return BarberServiceModel.fromJson(response['data'] as Map<String, dynamic>);
  }
}
