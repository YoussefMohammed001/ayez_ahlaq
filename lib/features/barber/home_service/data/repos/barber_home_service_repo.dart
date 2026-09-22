import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/network/response_guard.dart';
import '../../domain/entities/home_service_settings.dart';
import '../../domain/repos/i_barber_home_service_repo.dart';
import '../apis/barber_home_service_api.dart';
import '../models/home_service_settings_model.dart';

class BarberHomeServiceRepo implements IBarberHomeServiceRepo {
  final BarberHomeServiceApi _api;

  BarberHomeServiceRepo(this._api);

  @override
  Future<Either<Failure, HomeServiceSettings>> getSettings() async {
    final result = await _api.getSettings();
    return result.flatMap(_mapSettings);
  }

  @override
  Future<Either<Failure, HomeServiceSettings>> updateSettings({
    required bool enabled,
    num? price,
    String? note,
  }) async {
    final result = await _api.updateSettings(
      enabled: enabled,
      price: price,
      note: note,
    );
    return result.flatMap(_mapSettings);
  }

  Either<Failure, HomeServiceSettings> _mapSettings(dynamic response) {
    return requireDataMap(response).map(HomeServiceSettingsModel.fromJson);
  }
}
