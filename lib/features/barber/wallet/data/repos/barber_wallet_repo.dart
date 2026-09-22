import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/network/response_guard.dart';
import '../../domain/entities/barber_wallet.dart';
import '../../domain/repos/i_barber_wallet_repo.dart';
import '../apis/barber_wallet_api.dart';
import '../models/barber_wallet_model.dart';

class BarberWalletRepo implements IBarberWalletRepo {
  final BarberWalletApi _api;

  BarberWalletRepo(this._api);

  @override
  Future<Either<Failure, BarberWallet>> getWallet() async {
    final result = await _api.getWallet();
    return result.flatMap(_mapWallet);
  }

  Either<Failure, BarberWallet> _mapWallet(dynamic response) {
    return requireDataMap(response).map(BarberWalletModel.fromJson);
  }
}
