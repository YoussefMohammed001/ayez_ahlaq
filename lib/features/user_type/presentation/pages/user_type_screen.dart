import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/helpers/alerts.dart';
import '../../../../core/helpers/user_helpers.dart';
import '../../../../core/routes/route_paths.dart';
import '../../../../core/theme/heading_styles.dart';
import '../../../../shared/user_type.dart';
import '../widgets/user_type_card.dart';
import '../../../../generated/l10n.dart';
import '../../../../core/extensions/ext_theme.dart';

class UserTypeScreen extends StatelessWidget {
  const UserTypeScreen({super.key});

  Future<void> _select(BuildContext context, UserType type) async {
    await UserHelpers.setUserType(type);

    if (!context.mounted) return;

    if (type == UserType.merchant) {
      context.go(Routes.loginScreen);
      return;
    }

    if (type == UserType.barber) {
      context.go(Routes.barberLoginScreen);
      return;
    }

    showWarning(S().underDevelopment);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.fromLTRB(20.w, 40.h, 20.w, 24.h),
          children: [
            Text(S().appName, style: HeadingStyles.h1),
            SizedBox(height: 8.h),
            Text(
              S().chooseAccountType,
              style: TextStyle(
                fontSize: 13.sp,
                color: context.colorScheme.onSurfaceVariant,
                height: 1.7,
              ),
            ),
            SizedBox(height: 24.h),
            UserTypeCard(
              icon: Icons.person_rounded,
              title: S().customer,
              subtitle: S().customerHint,
              enabled: false,
              onTap: () => _select(context, UserType.customer),
            ),
            UserTypeCard(
              icon: Icons.content_cut_rounded,
              title: S().barber,
              subtitle: S().barberHint,
              onTap: () => _select(context, UserType.barber),
            ),
            UserTypeCard(
              icon: Icons.storefront_rounded,
              title: S().merchant,
              subtitle: S().merchantHint,
              onTap: () => _select(context, UserType.merchant),
            ),
          ],
        ),
      ),
    );
  }
}
