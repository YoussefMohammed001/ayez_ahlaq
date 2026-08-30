import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../repos/i_merchant_profile_repo.dart';

class DeletePhoneUseCase {
  final IMerchantProfileRepo _repo;

  DeletePhoneUseCase(this._repo);

  Future<Either<Failure, Unit>> call(int id) => _repo.deletePhone(id);
}
