import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../domain/entities/working_day.dart';
import '../../domain/repos/i_barber_hours_repo.dart';
import '../apis/barber_hours_api.dart';
import '../models/working_day_model.dart';

class BarberHoursRepo implements IBarberHoursRepo {
  final BarberHoursApi _api;

  BarberHoursRepo(this._api);

  @override
  Future<Either<Failure, List<WorkingDay>>> getHours() async {
    final result = await _api.getHours();
    return result.map(_mapMany);
  }

  @override
  Future<Either<Failure, List<WorkingDay>>> updateHours(
    List<WorkingDay> days,
  ) async {
    final result = await _api.updateHours(days.map(WorkingDayModel.toJson).toList());
    return result.map(_mapMany);
  }

  List<WorkingDay> _mapMany(dynamic response) {
    final data = response['data'] as List? ?? const [];
    return data
        .map((json) => WorkingDayModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}
