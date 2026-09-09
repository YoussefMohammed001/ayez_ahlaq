import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/customer_wallet.dart';

abstract class ICustomerWalletRepo {
  Future<Either<Failure, CustomerWallet>> getWallet();
}
