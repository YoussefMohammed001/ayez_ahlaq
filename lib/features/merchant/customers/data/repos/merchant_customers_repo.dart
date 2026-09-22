import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/network/response_guard.dart';
import '../../domain/entities/merchant_customer_page.dart';
import '../../domain/repos/i_merchant_customers_repo.dart';
import '../apis/merchant_customers_api.dart';
import '../models/merchant_customer_page_model.dart';

class MerchantCustomersRepo implements IMerchantCustomersRepo {
  final MerchantCustomersApi _api;

  MerchantCustomersRepo(this._api);

  @override
  Future<Either<Failure, MerchantCustomerPage>> getCustomers({
    required int page,
    required int size,
    String? query,
  }) async {
    final result = await _api.getCustomers(page: page, size: size, query: query);
    return result.flatMap(_mapPage);
  }

  Either<Failure, MerchantCustomerPage> _mapPage(dynamic response) {
    return requireDataMap(response).map(MerchantCustomerPageModel.fromJson);
  }
}
