import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../domain/entities/delivery_settings.dart';
import '../../domain/repos/i_merchant_delivery_repo.dart';
import '../apis/merchant_delivery_api.dart';
import '../models/delivery_settings_model.dart';

class MerchantDeliveryRepo implements IMerchantDeliveryRepo {
  final MerchantDeliveryApi _api;

  MerchantDeliveryRepo(this._api);

  @override
  Future<Either<Failure, DeliverySettings>> getDelivery() async {
    final result = await _api.getDelivery();
    return result.map(_mapOne);
  }

  @override
  Future<Either<Failure, DeliverySettings>> updateDelivery(
    DeliverySettings settings,
  ) async {
    final result = await _api.updateDelivery(
      DeliverySettingsModel.toJson(settings),
    );
    return result.map(_mapOne);
  }

  DeliverySettings _mapOne(dynamic response) {
    final data = response['data'] as Map<String, dynamic>?;
    if (data == null) return const DeliverySettings.disabled();
    return DeliverySettingsModel.fromJson(data);
  }
}
