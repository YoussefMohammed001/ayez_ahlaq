import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/home_service_settings.dart';
import '../repos/i_barber_home_service_repo.dart';

class GetHomeServiceSettingsUseCase {
  final IBarberHomeServiceRepo _repo;

  GetHomeServiceSettingsUseCase(this._repo);

  Future<Either<Failure, HomeServiceSettings>> call() => _repo.getSettings();
}
