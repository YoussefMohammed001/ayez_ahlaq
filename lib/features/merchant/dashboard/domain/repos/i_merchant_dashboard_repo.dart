import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/merchant_dashboard.dart';

abstract class IMerchantDashboardRepo {
  Future<Either<Failure, MerchantDashboard>> getDashboard();
}
