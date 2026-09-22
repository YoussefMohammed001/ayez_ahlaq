import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/money_direction.dart';
import '../entities/money_entry.dart';
import '../repos/i_barber_money_repo.dart';

class CreateMoneyEntryUseCase {
  final IBarberMoneyRepo _repo;

  CreateMoneyEntryUseCase(this._repo);

  Future<Either<Failure, MoneyEntry>> call({
    required String description,
    required int amount,
    required MoneyDirection direction,
    DateTime? entryDate,
  }) {
    return _repo.createEntry(
      description: description,
      amount: amount,
      direction: direction,
      entryDate: entryDate,
    );
  }
}
