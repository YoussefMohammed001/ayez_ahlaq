import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/merchant_member.dart';
import '../repos/i_merchant_member_self_repo.dart';

class GetMyMerchantMemberUseCase {
  final IMerchantMemberSelfRepo _repo;

  GetMyMerchantMemberUseCase(this._repo);

  Future<Either<Failure, MerchantMember>> call() => _repo.getMe();
}
