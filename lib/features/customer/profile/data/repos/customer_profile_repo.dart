import '../../../../../shared/auth/data/local/auth_local_data_source.dart';
import '../../domain/entities/customer_profile.dart';
import '../../domain/repos/i_customer_profile_repo.dart';

class CustomerProfileRepo implements ICustomerProfileRepo {
  final AuthLocalDataSource _authLocalDataSource;

  CustomerProfileRepo(this._authLocalDataSource);

  @override
  CustomerProfile getCachedProfile() {
    final identity = _authLocalDataSource.getCachedIdentity();
    return CustomerProfile(name: identity.name, phoneNumber: identity.phone);
  }
}
