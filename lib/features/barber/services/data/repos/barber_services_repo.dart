import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/network/response_guard.dart';
import '../../domain/entities/barber_service.dart';
import '../../domain/entities/own_service.dart';
import '../../domain/entities/service_catalog_item.dart';
import '../../domain/entities/shop_haircut_style.dart';
import '../../domain/repos/i_barber_services_repo.dart';
import '../apis/barber_services_api.dart';
import '../models/barber_service_model.dart';
import '../models/own_service_model.dart';
import '../models/service_catalog_item_model.dart';
import '../models/shop_haircut_style_model.dart';

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
    return result.flatMap(_mapOne);
  }

  @override
  Future<Either<Failure, BarberService>> updateService(
    BarberService service,
  ) async {
    final result = await _api.updateService(
      service.id,
      BarberServiceModel.toUpdateJson(service),
    );
    return result.flatMap(_mapOne);
  }

  @override
  Future<Either<Failure, Unit>> deleteService(int id) async {
    final result = await _api.deleteService(id);
    return result.map((_) => unit);
  }

  @override
  Future<Either<Failure, List<OwnService>>> getOwnServices() async {
    final result = await _api.getOwnServices();
    return result.map(_mapOwnServices);
  }

  @override
  Future<Either<Failure, OwnService>> createOwnService(
    String name,
    String description,
  ) async {
    final result = await _api.createOwnService(
      OwnServiceModel.toCreateJson(name, description),
    );
    return result.flatMap(_mapOwnOne);
  }

  @override
  Future<Either<Failure, Unit>> deleteOwnService(int id) async {
    final result = await _api.deleteOwnService(id);
    return result.map((_) => unit);
  }

  @override
  Future<Either<Failure, List<ShopHaircutStyle>>> getHaircutStyles() async {
    final result = await _api.getHaircutStyles();
    return result.map(_mapHaircutStyles);
  }

  @override
  Future<Either<Failure, ShopHaircutStyle>> updateHaircutStyle(
    int id, {
    required int priceDelta,
    required bool active,
  }) async {
    final result = await _api.updateHaircutStyle(id, {
      'priceDelta': priceDelta,
      'active': active,
    });
    return result.flatMap(_mapHaircutStyle);
  }

  List<ShopHaircutStyle> _mapHaircutStyles(dynamic response) {
    final data = response['data'] as List? ?? const [];
    return data
        .map(
          (json) =>
              ShopHaircutStyleModel.fromJson(json as Map<String, dynamic>),
        )
        .toList();
  }

  Either<Failure, ShopHaircutStyle> _mapHaircutStyle(dynamic response) {
    return requireDataMap(response).map(ShopHaircutStyleModel.fromJson);
  }

  List<OwnService> _mapOwnServices(dynamic response) {
    final data = response['data'] as List? ?? const [];
    return data
        .map((json) => OwnServiceModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  Either<Failure, OwnService> _mapOwnOne(dynamic response) {
    return requireDataMap(response).map(OwnServiceModel.fromJson);
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

  Either<Failure, BarberService> _mapOne(dynamic response) {
    return requireDataMap(response).map(BarberServiceModel.fromJson);
  }
}
