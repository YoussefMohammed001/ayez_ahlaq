import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../repos/i_merchant_member_self_repo.dart';

class ChangeMyMerchantPasswordUseCase {
  final IMerchantMemberSelfRepo _repo;

  ChangeMyMerchantPasswordUseCase(this._repo);

  Future<Either<Failure, Unit>> call(
    String currentPassword,
    String newPassword,
  ) => _repo.changePassword(currentPassword, newPassword);
}
