import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/network/response_guard.dart';
import '../../../../../shared/payment_methods/payment_method.dart';
import '../../../../../shared/payment_methods/payment_method_model.dart';
import '../../domain/entities/sale.dart';
import '../../domain/entities/sale_draft.dart';
import '../../domain/entities/sales_page.dart';
import '../../domain/repos/i_merchant_sales_repo.dart';
import '../apis/merchant_sales_api.dart';
import '../models/sale_model.dart';
import '../models/sales_page_model.dart';

class MerchantSalesRepo implements IMerchantSalesRepo {
  final MerchantSalesApi _api;

  MerchantSalesRepo(this._api);

  @override
  Future<Either<Failure, Sale>> createSale(SaleDraft draft) async {
    final result = await _api.createSale({
      'customerName': ?draft.customerName,
      'customerPhone': ?draft.customerPhone,
      'paymentMethod': ?draft.paymentMethod,
      'note': ?draft.note,
      'discount': draft.discount,
      'items': [
        for (final line in draft.lines)
          {'productId': line.productId, 'quantity': line.quantity},
      ],
    });
    return result.flatMap(_mapOne);
  }

  @override
  Future<Either<Failure, SalesPage>> getSales({
    required int page,
    required int size,
  }) async {
    final result = await _api.getSales(page: page, size: size);
    return result.flatMap(
      (response) => requireDataMap(response).map(SalesPageModel.fromJson),
    );
  }

  @override
  Future<Either<Failure, Sale>> cancelSale(int id) async {
    final result = await _api.cancelSale(id);
    return result.flatMap(_mapOne);
  }

  @override
  Future<Either<Failure, List<PaymentMethod>>> getPaymentMethods() async {
    final result = await _api.getPaymentMethods();
    return result.map(_methodsFrom);
  }

  Either<Failure, Sale> _mapOne(dynamic response) =>
      requireDataMap(response).map(SaleModel.fromJson);

  List<PaymentMethod> _methodsFrom(dynamic response) {
    final data = response['data'] as List? ?? const [];
    return [
      for (final json in data.cast<Map<String, dynamic>>())
        if (json['enabled'] as bool? ?? true) PaymentMethodModel.fromJson(json),
    ];
  }
}
