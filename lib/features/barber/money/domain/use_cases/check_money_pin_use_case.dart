import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../repos/i_barber_money_pin_repo.dart';

class CheckMoneyPinUseCase {
  final IBarberMoneyPinRepo _repo;

  CheckMoneyPinUseCase(this._repo);

  Future<Either<Failure, bool>> call() => _repo.hasPin();
}
