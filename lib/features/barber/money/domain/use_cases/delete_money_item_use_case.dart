import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../repos/i_barber_money_repo.dart';

class DeleteMoneyItemUseCase {
  final IBarberMoneyRepo _repo;

  DeleteMoneyItemUseCase(this._repo);

  Future<Either<Failure, void>> call(int id) => _repo.deleteItem(id);
}
