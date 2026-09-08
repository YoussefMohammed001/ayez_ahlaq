import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../shared/sponsorship/sponsorship.dart';
import '../repos/i_merchant_sponsorship_repo.dart';

class BuyMerchantSponsorshipUseCase {
  final IMerchantSponsorshipRepo _repo;

  BuyMerchantSponsorshipUseCase(this._repo);

  Future<Either<Failure, Sponsorship>> call() => _repo.buySponsorship();
}
