import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../shared/payment_methods/payment_method.dart';
import '../entities/sale.dart';
import '../entities/sale_draft.dart';
import '../entities/sales_page.dart';

abstract class IMerchantSalesRepo {
  Future<Either<Failure, Sale>> createSale(SaleDraft draft);

  Future<Either<Failure, SalesPage>> getSales({
    required int page,
    required int size,
  });

  Future<Either<Failure, Sale>> cancelSale(int id);

  Future<Either<Failure, List<PaymentMethod>>> getPaymentMethods();
}
