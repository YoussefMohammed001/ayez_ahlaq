import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/helpers/user_helpers.dart';
import '../../../../../core/theme/styles.dart';
import '../../../../../core/widgets/avatar_circle.dart';
import '../../../../../core/widgets/custom_text.dart';
import '../../../../../generated/l10n.dart';
import 'sub_merchant_menu.dart';

class SubMerchantAccountView extends StatelessWidget {
  final Future<void> Function() onLogout;

  const SubMerchantAccountView({super.key, required this.onLogout});

  @override
  Widget build(BuildContext context) {
    final name = UserHelpers.displayName;

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          children: [
            SizedBox(height: 20.h),
            Center(
              child: AvatarCircle(
                initials: name.isEmpty
                    ? S().avatarFallback
                    : name.substring(0, 1),
                size: 84.r,
              ),
            ),
            SizedBox(height: 10.h),
            Center(child: AppText(name, style: font20w700)),
            SizedBox(height: 18.h),
            SubMerchantMenu(onLogout: onLogout),
            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }
}
