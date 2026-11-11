import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/sale.dart';
import '../entities/sale_draft.dart';
import '../repos/i_merchant_sales_repo.dart';

class CreateSaleUseCase {
  final IMerchantSalesRepo _repo;

  CreateSaleUseCase(this._repo);

  Future<Either<Failure, Sale>> call(SaleDraft draft) =>
      _repo.createSale(draft);
}
