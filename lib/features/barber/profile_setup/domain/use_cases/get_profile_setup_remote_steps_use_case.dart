import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../../hours/domain/use_cases/get_barber_hours_use_case.dart';
import '../../../services/domain/use_cases/get_barber_services_use_case.dart';
import '../entities/profile_setup_step.dart';

class GetProfileSetupRemoteStepsUseCase {
  final GetBarberHoursUseCase _getHours;
  final GetBarberServicesUseCase _getServices;

  GetProfileSetupRemoteStepsUseCase(this._getHours, this._getServices);

  Future<Either<Failure, Set<ProfileSetupStep>>> call() async {
    final pendingHours = _getHours();
    final pendingServices = _getServices();
    final hours = await pendingHours;
    final services = await pendingServices;

    return hours.flatMap(
      (days) => services.map(
        (list) => {
          if (days.any((day) => day.isOpen)) ProfileSetupStep.hours,
          if (list.any((service) => service.active)) ProfileSetupStep.services,
        },
      ),
    );
  }
}
