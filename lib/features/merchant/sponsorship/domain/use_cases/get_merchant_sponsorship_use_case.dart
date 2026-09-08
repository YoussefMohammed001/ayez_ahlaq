import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../shared/sponsorship/sponsorship.dart';
import '../repos/i_merchant_sponsorship_repo.dart';

class GetMerchantSponsorshipUseCase {
  final IMerchantSponsorshipRepo _repo;

  GetMerchantSponsorshipUseCase(this._repo);

  Future<Either<Failure, Sponsorship>> call() => _repo.getSponsorship();
}
