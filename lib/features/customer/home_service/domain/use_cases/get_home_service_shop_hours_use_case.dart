import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../../../barber/hours/domain/entities/working_day.dart';
import '../repos/i_customer_home_service_repo.dart';

class GetHomeServiceShopHoursUseCase {
  final ICustomerHomeServiceRepo _repo;

  GetHomeServiceShopHoursUseCase(this._repo);

  Future<Either<Failure, List<WorkingDay>>> call(int shopId) =>
      _repo.getHours(shopId);
}
