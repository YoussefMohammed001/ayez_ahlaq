import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/money_summary.dart';
import '../repos/i_barber_money_repo.dart';

class GetMoneySummaryUseCase {
  final IBarberMoneyRepo _repo;

  GetMoneySummaryUseCase(this._repo);

  Future<Either<Failure, MoneySummary>> call() => _repo.getSummary();
}
