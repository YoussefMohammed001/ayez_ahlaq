import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../shared/payment_methods/payment_method.dart';

abstract class ICustomerPaymentMethodsRepo {
  Future<Either<Failure, List<PaymentMethod>>> getEnabledPaymentMethods();
}
