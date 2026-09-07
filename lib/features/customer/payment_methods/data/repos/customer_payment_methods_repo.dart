import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../domain/entities/payment_method.dart';
import '../../domain/repos/i_customer_payment_methods_repo.dart';
import '../apis/customer_payment_methods_api.dart';
import '../models/payment_method_model.dart';

class CustomerPaymentMethodsRepo implements ICustomerPaymentMethodsRepo {
  final CustomerPaymentMethodsApi _api;

  CustomerPaymentMethodsRepo(this._api);

  @override
  Future<Either<Failure, List<PaymentMethod>>> getEnabledPaymentMethods() async {
    final result = await _api.getEnabledPaymentMethods();
    return result.map(_mapMany);
  }

  List<PaymentMethod> _mapMany(dynamic response) {
    final data = response['data'];
    final codes = data is List ? data : const [];

    return codes
        .map((entry) {
          final code = entry is Map ? entry['code'] as String? : entry as String?;
          return code;
        })
        .whereType<String>()
        .map(PaymentMethodModel.fromCode)
        .toList();
  }
}
