import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/merchant_phone.dart';
import '../repos/i_merchant_profile_repo.dart';

class AddPhoneUseCase {
  final IMerchantProfileRepo _repo;

  AddPhoneUseCase(this._repo);

  Future<Either<Failure, MerchantPhone>> call(String phone, String? label) =>
      _repo.addPhone(phone, label);
}
