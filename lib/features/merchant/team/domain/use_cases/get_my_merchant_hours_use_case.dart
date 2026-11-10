import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../../../barber/hours/domain/entities/working_day.dart';
import '../repos/i_merchant_member_self_repo.dart';

class GetMyMerchantHoursUseCase {
  final IMerchantMemberSelfRepo _repo;

  GetMyMerchantHoursUseCase(this._repo);

  Future<Either<Failure, List<WorkingDay>>> call() => _repo.getMyHours();
}
