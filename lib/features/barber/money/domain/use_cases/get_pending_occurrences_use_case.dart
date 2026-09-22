import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/money_occurrence.dart';
import '../repos/i_barber_money_repo.dart';

class GetPendingOccurrencesUseCase {
  final IBarberMoneyRepo _repo;

  GetPendingOccurrencesUseCase(this._repo);

  Future<Either<Failure, List<MoneyOccurrence>>> call() =>
      _repo.getPendingOccurrences();
}
