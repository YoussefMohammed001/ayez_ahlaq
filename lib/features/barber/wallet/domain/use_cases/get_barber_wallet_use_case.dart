import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/barber_wallet.dart';
import '../repos/i_barber_wallet_repo.dart';

class GetBarberWalletUseCase {
  final IBarberWalletRepo _repo;

  GetBarberWalletUseCase(this._repo);

  Future<Either<Failure, BarberWallet>> call() => _repo.getWallet();
}
