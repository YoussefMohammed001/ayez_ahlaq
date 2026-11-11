import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/sale.dart';
import '../repos/i_merchant_sales_repo.dart';

class CancelSaleUseCase {
  final IMerchantSalesRepo _repo;

  CancelSaleUseCase(this._repo);

  Future<Either<Failure, Sale>> call(int id) => _repo.cancelSale(id);
}
