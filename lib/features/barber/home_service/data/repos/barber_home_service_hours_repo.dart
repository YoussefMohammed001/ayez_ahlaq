import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../../hours/data/models/working_day_model.dart';
import '../../../hours/domain/entities/working_day.dart';
import '../../domain/repos/i_barber_home_service_hours_repo.dart';
import '../apis/barber_home_service_hours_api.dart';

class BarberHomeServiceHoursRepo implements IBarberHomeServiceHoursRepo {
  final BarberHomeServiceHoursApi _api;

  BarberHomeServiceHoursRepo(this._api);

  @override
  Future<Either<Failure, List<WorkingDay>>> getHours() async {
    final result = await _api.getHours();
    return result.map(_mapMany);
  }

  @override
  Future<Either<Failure, List<WorkingDay>>> updateHours(
    List<WorkingDay> days,
  ) async {
    final result = await _api.updateHours(
      days.map(WorkingDayModel.toJson).toList(),
    );
    return result.map(_mapMany);
  }

  List<WorkingDay> _mapMany(dynamic response) {
    final data = response['data'] as List? ?? const [];
    return data
        .map((json) => WorkingDayModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}
