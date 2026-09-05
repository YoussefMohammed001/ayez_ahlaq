import '../entities/customer_profile.dart';
import '../repos/i_customer_profile_repo.dart';

class GetCachedProfileUseCase {
  final ICustomerProfileRepo _repo;

  GetCachedProfileUseCase(this._repo);

  CustomerProfile call() => _repo.getCachedProfile();
}
