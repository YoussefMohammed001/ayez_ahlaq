import 'dart:developer';
import '../../../device_token/presentation/services/customer_device_token_sync_service.dart';
import '../repos/i_customer_auth_repo.dart';

class CustomerLogoutUseCase {
  final ICustomerAuthRepo _repo;
  final CustomerDeviceTokenSyncService _deviceTokenSync;

  CustomerLogoutUseCase(this._repo, this._deviceTokenSync);

  Future<void> call() async {
    try {
      await _deviceTokenSync.unregisterAllTokens();
    } catch (e, st) {
      log('Error unregistering device tokens: $e\n$st');
    }
    await _repo.logout();
  }
}
