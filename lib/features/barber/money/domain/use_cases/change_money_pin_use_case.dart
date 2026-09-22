import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../repos/i_barber_money_pin_repo.dart';

class ChangeMoneyPinUseCase {
  final IBarberMoneyPinRepo _repo;

  ChangeMoneyPinUseCase(this._repo);

  Future<Either<Failure, void>> call({
    required String currentPin,
    required String newPin,
  }) {
    return _repo.change(currentPin: currentPin, newPin: newPin);
  }
}
