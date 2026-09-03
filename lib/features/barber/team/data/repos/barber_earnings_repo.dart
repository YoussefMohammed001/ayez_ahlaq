import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../domain/entities/earnings.dart';
import '../../domain/repos/i_barber_earnings_repo.dart';
import '../apis/barber_earnings_api.dart';
import '../models/earnings_model.dart';

class BarberEarningsRepo implements IBarberEarningsRepo {
  final BarberEarningsApi _api;

  BarberEarningsRepo(this._api);

  @override
  Future<Either<Failure, Earnings>> getEarnings() async {
    final result = await _api.getEarnings();
    return result.map(
      (response) =>
          EarningsModel.fromJson(response['data'] as Map<String, dynamic>),
    );
  }
}
