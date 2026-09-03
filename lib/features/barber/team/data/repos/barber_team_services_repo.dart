import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../../services/data/models/barber_service_model.dart';
import '../../../services/data/models/service_catalog_item_model.dart';
import '../../../services/domain/entities/barber_service.dart';
import '../../../services/domain/entities/service_catalog_item.dart';
import '../../domain/repos/i_barber_team_services_repo.dart';
import '../apis/barber_team_services_api.dart';

class BarberTeamServicesRepo implements IBarberTeamServicesRepo {
  final BarberTeamServicesApi _api;

  BarberTeamServicesRepo(this._api);

  @override
  Future<Either<Failure, List<ServiceCatalogItem>>> getCatalog(
    int memberId,
  ) async {
    final result = await _api.getCatalog(memberId);
    return result.map(_mapCatalog);
  }

  @override
  Future<Either<Failure, List<BarberService>>> getServices(
    int memberId,
  ) async {
    final result = await _api.getServices(memberId);
    return result.map(_mapServices);
  }

  @override
  Future<Either<Failure, BarberService>> createService(
    int memberId,
    BarberService service,
  ) async {
    final result = await _api.createService(
      memberId,
      BarberServiceModel.toCreateJson(service),
    );
    return result.map(_mapOne);
  }

  @override
  Future<Either<Failure, BarberService>> updateService(
    int memberId,
    BarberService service,
  ) async {
    final result = await _api.updateService(
      memberId,
      service.id,
      BarberServiceModel.toUpdateJson(service),
    );
    return result.map(_mapOne);
  }

  @override
  Future<Either<Failure, Unit>> deleteService(
    int memberId,
    int serviceId,
  ) async {
    final result = await _api.deleteService(memberId, serviceId);
    return result.map((_) => unit);
  }

  List<ServiceCatalogItem> _mapCatalog(dynamic response) {
    final data = response['data'] as List? ?? const [];
    return data
        .map(
          (json) => ServiceCatalogItemModel.fromJson(json as Map<String, dynamic>),
        )
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
