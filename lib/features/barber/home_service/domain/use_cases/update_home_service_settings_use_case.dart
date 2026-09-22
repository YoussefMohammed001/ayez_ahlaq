import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/home_service_settings.dart';
import '../repos/i_barber_home_service_repo.dart';

class UpdateHomeServiceSettingsUseCase {
  final IBarberHomeServiceRepo _repo;

  UpdateHomeServiceSettingsUseCase(this._repo);

  Future<Either<Failure, HomeServiceSettings>> call({
    required bool enabled,
    num? price,
    String? note,
  }) => _repo.updateSettings(enabled: enabled, price: price, note: note);
}
