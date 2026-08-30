import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/merchant_phone.dart';
import '../repos/i_merchant_profile_repo.dart';

class GetPhonesUseCase {
  final IMerchantProfileRepo _repo;

  GetPhonesUseCase(this._repo);

  Future<Either<Failure, List<MerchantPhone>>> call() => _repo.getPhones();
}
