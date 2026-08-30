import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../domain/entities/merchant_dashboard.dart';
import '../../domain/repos/i_merchant_dashboard_repo.dart';
import '../apis/merchant_dashboard_api.dart';
import '../models/merchant_dashboard_model.dart';

class MerchantDashboardRepo implements IMerchantDashboardRepo {
  final MerchantDashboardApi _api;

  MerchantDashboardRepo(this._api);

  @override
  Future<Either<Failure, MerchantDashboard>> getDashboard() async {
    final result = await _api.getDashboard();
    return result.map(
      (response) => MerchantDashboardModel.fromJson(
        response['data'] as Map<String, dynamic>,
      ),
    );
  }
}
