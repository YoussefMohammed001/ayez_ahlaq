import 'package:flutter/widgets.dart';
import '../../../../../core/di/services_locator.dart';
import '../../../../../core/helpers/alerts.dart';
import '../../../../../generated/l10n.dart';
import '../manager/merchant_profile_cubit.dart';

bool get isMerchantActive =>
    sl<MerchantProfileCubit>().state.profile?.active ?? false;

bool get canEditMerchantIdentity => !isMerchantActive;

bool guardMerchantIdentityEdit() {
  if (canEditMerchantIdentity) return true;
  showError(S().identityLockedAction);
  return false;
}

extension MerchantAccess on BuildContext {
  bool get canEditIdentity => canEditMerchantIdentity;
}
