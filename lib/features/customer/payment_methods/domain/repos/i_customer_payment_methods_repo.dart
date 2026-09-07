import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/payment_method.dart';

abstract class ICustomerPaymentMethodsRepo {
  Future<Either<Failure, List<PaymentMethod>>> getEnabledPaymentMethods();
}
