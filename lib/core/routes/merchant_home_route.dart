import '../helpers/user_helpers.dart';
import 'route_paths.dart';

String get merchantHomeRoute => UserHelpers.merchantAccountKind.isSubMerchant
    ? Routes.subMerchantShell
    : Routes.merchantShell;
