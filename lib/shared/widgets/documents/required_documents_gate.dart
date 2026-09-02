import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/helpers/show_confirm_dialog.dart';
import '../../../core/extensions/ext_theme.dart';
import '../../../core/theme/heading_styles.dart';
import '../../../generated/l10n.dart';

class RequiredDocumentsGate extends StatelessWidget {
  final bool isBlocked;
  final WidgetBuilder builder;
  final WidgetBuilder blockedBuilder;
  final VoidCallback onLogout;

  const RequiredDocumentsGate({
    super.key,
    required this.isBlocked,
    required this.builder,
    required this.blockedBuilder,
    required this.onLogout,
  });

  Future<void> _confirmLogout(BuildContext context) async {
    final confirmed = await showConfirmDialog(
      context,
      title: S().logoutTitle,
      message: S().logoutConfirm,
      confirmLabel: S().logoutTitle,
      icon: Icons.logout_rounded,
    );

    if (confirmed) onLogout();
  }

  @override
  Widget build(BuildContext context) {
    if (!isBlocked) return builder(context);

    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(S().documentsBlockedTitle, style: HeadingStyles.h4),
          actions: [
            IconButton(
              icon: Icon(
                Icons.logout_rounded,
                color: context.semantic.warning,
                size: 20.r,
              ),
              onPressed: () => _confirmLogout(context),
            ),
            SizedBox(width: 8.w),
          ],
        ),
        body: blockedBuilder(context),
      ),
    );
  }
}
