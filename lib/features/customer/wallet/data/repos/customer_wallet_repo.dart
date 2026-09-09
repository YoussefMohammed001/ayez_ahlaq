import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../domain/entities/customer_wallet.dart';
import '../../domain/repos/i_customer_wallet_repo.dart';
import '../apis/customer_wallet_api.dart';
import '../models/customer_wallet_model.dart';

class CustomerWalletRepo implements ICustomerWalletRepo {
  final CustomerWalletApi _api;

  CustomerWalletRepo(this._api);

  @override
  Future<Either<Failure, CustomerWallet>> getWallet() async {
    final result = await _api.getWallet();
    return result.map(_mapWallet);
  }

  CustomerWallet _mapWallet(dynamic response) {
    return CustomerWalletModel.fromJson(response['data'] as Map<String, dynamic>);
  }
}
