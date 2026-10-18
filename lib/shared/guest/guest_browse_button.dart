import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../core/extensions/ext_theme.dart';
import '../../core/routes/route_paths.dart';
import '../../generated/l10n.dart';

class GuestBrowseButton extends StatelessWidget {
  const GuestBrowseButton({super.key});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: () => context.go(Routes.customerShell),
      style: OutlinedButton.styleFrom(
        minimumSize: Size.fromHeight(52.h),
        foregroundColor: context.colorScheme.onSurface,
        side: BorderSide(color: context.colorScheme.outline),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14.r),
        ),
      ),
      icon: Icon(Icons.storefront_outlined, size: 20.r),
      label: Text(
        S().browseAsGuest,
        style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w700),
      ),
    );
  }
}
