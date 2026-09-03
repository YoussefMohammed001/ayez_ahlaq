import 'dart:developer';
import '../../../device_token/presentation/services/merchant_device_token_sync_service.dart';
import '../repos/i_merchant_auth_repo.dart';

class MerchantLogoutUseCase {
  final IMerchantAuthRepo _repo;
  final MerchantDeviceTokenSyncService _deviceTokenSync;

  MerchantLogoutUseCase(this._repo, this._deviceTokenSync);

  Future<void> call() async {
    try {
      await _deviceTokenSync.unregisterAllTokens();
    } catch (e, st) {
      log('Error unregistering device tokens: $e\n$st');
    }
    await _repo.logout();
  }
}
