import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../repos/i_barber_money_repo.dart';

class DismissOccurrenceUseCase {
  final IBarberMoneyRepo _repo;

  DismissOccurrenceUseCase(this._repo);

  Future<Either<Failure, void>> call(int id) => _repo.dismissOccurrence(id);
}
