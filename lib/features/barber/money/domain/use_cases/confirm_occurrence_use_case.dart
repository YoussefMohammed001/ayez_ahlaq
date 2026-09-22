import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../repos/i_barber_money_repo.dart';

class ConfirmOccurrenceUseCase {
  final IBarberMoneyRepo _repo;

  ConfirmOccurrenceUseCase(this._repo);

  Future<Either<Failure, void>> call({
    required int id,
    String? description,
    int? amount,
  }) {
    return _repo.confirmOccurrence(id: id, description: description, amount: amount);
  }
}
