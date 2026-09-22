import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../repos/i_barber_money_pin_repo.dart';

class SetupMoneyPinUseCase {
  final IBarberMoneyPinRepo _repo;

  SetupMoneyPinUseCase(this._repo);

  Future<Either<Failure, void>> call(String pin) => _repo.setup(pin);
}
