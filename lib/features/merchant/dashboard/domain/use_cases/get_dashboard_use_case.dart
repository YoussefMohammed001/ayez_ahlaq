import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/merchant_dashboard.dart';
import '../repos/i_merchant_dashboard_repo.dart';

class GetDashboardUseCase {
  final IMerchantDashboardRepo _repo;

  GetDashboardUseCase(this._repo);

  Future<Either<Failure, MerchantDashboard>> call() => _repo.getDashboard();
}
