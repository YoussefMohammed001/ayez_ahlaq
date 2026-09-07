import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../repos/i_merchant_profile_repo.dart';

class DeleteMerchantAccountUseCase {
  final IMerchantProfileRepo _repo;

  DeleteMerchantAccountUseCase(this._repo);

  Future<Either<Failure, Unit>> call(String password) =>
      _repo.deleteAccount(password);
}
