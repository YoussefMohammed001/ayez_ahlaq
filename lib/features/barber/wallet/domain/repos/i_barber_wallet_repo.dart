import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/barber_wallet.dart';

abstract class IBarberWalletRepo {
  Future<Either<Failure, BarberWallet>> getWallet();
}
