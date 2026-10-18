import 'package:flutter/widgets.dart';
import '../../../../../core/helpers/alerts.dart';
import '../../../../../generated/l10n.dart';
import '../manager/merchant_profile_cubit.dart';
import '../../../../../core/session/session_scope.dart';

bool get isMerchantActive =>
    SessionScope.cubit<MerchantProfileCubit>().state.profile?.active ?? false;

bool get canEditMerchantIdentity => !isMerchantActive;

bool guardMerchantIdentityEdit() {
  if (canEditMerchantIdentity) return true;
  showError(S().identityLockedAction);
  return false;
}

extension MerchantAccess on BuildContext {
  bool get canEditIdentity => canEditMerchantIdentity;
}
