import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../shared/payment_methods/payment_method.dart';
import '../repos/i_merchant_sales_repo.dart';

class GetSalePaymentMethodsUseCase {
  final IMerchantSalesRepo _repo;

  GetSalePaymentMethodsUseCase(this._repo);

  Future<Either<Failure, List<PaymentMethod>>> call() =>
      _repo.getPaymentMethods();
}
