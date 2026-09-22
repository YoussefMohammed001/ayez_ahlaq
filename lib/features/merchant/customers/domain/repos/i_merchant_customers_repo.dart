import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/merchant_customer_page.dart';

abstract class IMerchantCustomersRepo {
  Future<Either<Failure, MerchantCustomerPage>> getCustomers({
    required int page,
    required int size,
    String? query,
  });
}
