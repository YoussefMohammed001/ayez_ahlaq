import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../shared/payment_methods/payment_method.dart';
import '../repos/i_customer_payment_methods_repo.dart';

class GetEnabledPaymentMethodsUseCase {
  final ICustomerPaymentMethodsRepo _repo;

  GetEnabledPaymentMethodsUseCase(this._repo);

  Future<Either<Failure, List<PaymentMethod>>> call() =>
      _repo.getEnabledPaymentMethods();
}
