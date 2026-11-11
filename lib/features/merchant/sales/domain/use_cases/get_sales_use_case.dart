import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/sales_page.dart';
import '../repos/i_merchant_sales_repo.dart';

class GetSalesUseCase {
  final IMerchantSalesRepo _repo;

  GetSalesUseCase(this._repo);

  Future<Either<Failure, SalesPage>> call({
    required int page,
    required int size,
  }) => _repo.getSales(page: page, size: size);
}
