import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../core/helpers/user_helpers.dart';
import '../../../../../core/routes/route_paths.dart';
import '../../../../../core/theme/heading_styles.dart';
import '../../../../../generated/l10n.dart';
import '../../../../user_type/presentation/widgets/user_type_card.dart';
import '../../domain/entities/barber_account_kind.dart';

class BarberRoleScreen extends StatelessWidget {
  const BarberRoleScreen({super.key});

  Future<void> _select(BuildContext context, BarberAccountKind kind) async {
    await UserHelpers.setBarberAccountKind(kind);
    if (!context.mounted) return;
    context.go(Routes.barberLoginScreen);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.fromLTRB(20.w, 40.h, 20.w, 24.h),
          children: [
            Text(S().barber, style: HeadingStyles.h1),
            SizedBox(height: 8.h),
            Text(
              S().chooseBarberRole,
              style: TextStyle(
                fontSize: 13.sp,
                color: context.colorScheme.onSurfaceVariant,
                height: 1.7,
              ),
            ),
            SizedBox(height: 24.h),
            UserTypeCard(
              icon: Icons.storefront_rounded,
              title: S().shopOwner,
              subtitle: S().shopOwnerHint,
              onTap: () => _select(context, BarberAccountKind.owner),
            ),
            UserTypeCard(
              icon: Icons.content_cut_rounded,
              title: S().teamMember,
              subtitle: S().teamMemberHint,
              onTap: () => _select(context, BarberAccountKind.teamMember),
            ),
            TextButton(
              onPressed: () => context.go(Routes.userTypeScreen),
              child: Text(S().changeAccountType),
            ),
          ],
        ),
      ),
    );
  }
}
