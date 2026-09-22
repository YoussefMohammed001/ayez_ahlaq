import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/money_direction.dart';
import '../entities/money_frequency.dart';
import '../entities/money_item.dart';
import '../repos/i_barber_money_repo.dart';

class UpdateMoneyItemUseCase {
  final IBarberMoneyRepo _repo;

  UpdateMoneyItemUseCase(this._repo);

  Future<Either<Failure, MoneyItem>> call({
    required int id,
    required String description,
    required int amount,
    required MoneyDirection direction,
    required MoneyFrequency frequency,
    int? dayOfWeek,
    int? dayOfMonth,
    required bool active,
  }) {
    return _repo.updateItem(
      id: id,
      description: description,
      amount: amount,
      direction: direction,
      frequency: frequency,
      dayOfWeek: dayOfWeek,
      dayOfMonth: dayOfMonth,
      active: active,
    );
  }
}
