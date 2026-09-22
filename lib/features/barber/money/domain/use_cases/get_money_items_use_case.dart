import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/money_item.dart';
import '../repos/i_barber_money_repo.dart';

class GetMoneyItemsUseCase {
  final IBarberMoneyRepo _repo;

  GetMoneyItemsUseCase(this._repo);

  Future<Either<Failure, List<MoneyItem>>> call() => _repo.getItems();
}
