import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/money_direction.dart';
import '../entities/money_frequency.dart';
import '../entities/money_item.dart';
import '../repos/i_barber_money_repo.dart';

class CreateMoneyItemUseCase {
  final IBarberMoneyRepo _repo;

  CreateMoneyItemUseCase(this._repo);

  Future<Either<Failure, MoneyItem>> call({
    required String description,
    required int amount,
    required MoneyDirection direction,
    required MoneyFrequency frequency,
    int? dayOfWeek,
    int? dayOfMonth,
  }) {
    return _repo.createItem(
      description: description,
      amount: amount,
      direction: direction,
      frequency: frequency,
      dayOfWeek: dayOfWeek,
      dayOfMonth: dayOfMonth,
    );
  }
}
