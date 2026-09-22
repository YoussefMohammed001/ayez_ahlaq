import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/money_pin_reset_status.dart';

abstract class IBarberMoneyPinRepo {
  Future<Either<Failure, bool>> hasPin();

  Future<Either<Failure, void>> setup(String pin);

  Future<Either<Failure, void>> verify(String pin);

  Future<Either<Failure, void>> change({
    required String currentPin,
    required String newPin,
  });

  Future<Either<Failure, MoneyPinResetStatus>> getResetRequestStatus();

  Future<Either<Failure, MoneyPinResetStatus>> sendResetRequest();
}
