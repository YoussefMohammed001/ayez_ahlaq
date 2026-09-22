import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/home_service_settings.dart';

abstract class IBarberHomeServiceRepo {
  Future<Either<Failure, HomeServiceSettings>> getSettings();

  Future<Either<Failure, HomeServiceSettings>> updateSettings({
    required bool enabled,
    num? price,
    String? note,
  });
}
