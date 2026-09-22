import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/money_pin_reset_status.dart';
import '../repos/i_barber_money_pin_repo.dart';

class GetMoneyPinResetStatusUseCase {
  final IBarberMoneyPinRepo _repo;

  GetMoneyPinResetStatusUseCase(this._repo);

  Future<Either<Failure, MoneyPinResetStatus>> call() =>
      _repo.getResetRequestStatus();
}
