import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../shared/payment_methods/payment_method.dart';
import '../repos/i_barber_payment_methods_repo.dart';

class GetBarberPaymentMethodsUseCase {
  final IBarberPaymentMethodsRepo _repo;

  GetBarberPaymentMethodsUseCase(this._repo);

  Future<Either<Failure, List<PaymentMethod>>> call() =>
      _repo.getEnabledPaymentMethods();
}
