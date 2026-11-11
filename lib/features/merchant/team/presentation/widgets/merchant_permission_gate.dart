import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/helpers/user_helpers.dart';
import '../../../../../core/session/session_scope.dart';
import '../../domain/entities/merchant_member_permissions.dart';
import '../manager/my_merchant_member_cubit.dart';
import '../manager/my_merchant_member_state.dart';

typedef MerchantPermissionCheck = bool Function(MerchantMemberPermissions);

class MerchantPermissionGate extends StatelessWidget {
  final MerchantPermissionCheck allows;
  final Widget Function(BuildContext context, bool allowed) builder;

  const MerchantPermissionGate({
    super.key,
    required this.allows,
    required this.builder,
  });

  static bool canManageProducts(MerchantMemberPermissions permissions) =>
      permissions.canManageProducts;

  static bool canSell(MerchantMemberPermissions permissions) =>
      permissions.canSell;

  bool _allowed(MyMerchantMemberState state) {
    final member = state.member;
    return member != null && allows(member.permissions);
  }

  @override
  Widget build(BuildContext context) {
    if (!UserHelpers.merchantAccountKind.isSubMerchant) {
      return builder(context, true);
    }

    return BlocBuilder<MyMerchantMemberCubit, MyMerchantMemberState>(
      bloc: SessionScope.cubit<MyMerchantMemberCubit>(),
      buildWhen: (previous, current) => _allowed(previous) != _allowed(current),
      builder: (context, state) => builder(context, _allowed(state)),
    );
  }
}
