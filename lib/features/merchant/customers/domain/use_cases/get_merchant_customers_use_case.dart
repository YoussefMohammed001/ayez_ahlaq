import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/merchant_customer_page.dart';
import '../repos/i_merchant_customers_repo.dart';

class GetMerchantCustomersUseCase {
  final IMerchantCustomersRepo _repo;

  GetMerchantCustomersUseCase(this._repo);

  Future<Either<Failure, MerchantCustomerPage>> call({
    required int page,
    required int size,
    String? query,
  }) => _repo.getCustomers(page: page, size: size, query: query);
}
