import '../repos/i_merchant_auth_repo.dart';

class MerchantLogoutUseCase {
  final IMerchantAuthRepo _repo;

  MerchantLogoutUseCase(this._repo);

  Future<void> call() => _repo.logout();
}
