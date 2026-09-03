import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/earnings.dart';
import '../repos/i_barber_earnings_repo.dart';

class GetEarningsUseCase {
  final IBarberEarningsRepo _repo;

  GetEarningsUseCase(this._repo);

  Future<Either<Failure, Earnings>> call() => _repo.getEarnings();
}
