import 'package:dartz/dartz.dart';
import '../../../../../../core/error/failure.dart';
import '../../domain/entities/storefront_delivery_settings.dart';
import '../../domain/repos/i_barber_storefront_delivery_repo.dart';
import '../apis/barber_storefront_delivery_api.dart';
import '../models/storefront_delivery_settings_model.dart';

class BarberStorefrontDeliveryRepo implements IBarberStorefrontDeliveryRepo {
  final BarberStorefrontDeliveryApi _api;

  BarberStorefrontDeliveryRepo(this._api);

  @override
  Future<Either<Failure, StorefrontDeliverySettings>> getDelivery() async {
    final result = await _api.getDelivery();
    return result.map(_mapOne);
  }

  @override
  Future<Either<Failure, StorefrontDeliverySettings>> updateDelivery(
    StorefrontDeliverySettings settings,
  ) async {
    final result = await _api.updateDelivery(
      StorefrontDeliverySettingsModel.toJson(settings),
    );
    return result.map(_mapOne);
  }

  StorefrontDeliverySettings _mapOne(dynamic response) {
    final data = response['data'] as Map<String, dynamic>?;
    if (data == null) return const StorefrontDeliverySettings.disabled();
    return StorefrontDeliverySettingsModel.fromJson(data);
  }
}
