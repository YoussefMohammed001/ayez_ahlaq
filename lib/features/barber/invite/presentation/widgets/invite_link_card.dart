import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/helpers/alerts.dart';
import '../../../../../core/widgets/app_card.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../generated/l10n.dart';

class InviteLinkCard extends StatelessWidget {
  final String url;

  const InviteLinkCard({super.key, required this.url});

  Future<void> _copy(BuildContext context) async {
    await Clipboard.setData(ClipboardData(text: url));
    if (context.mounted) showSuccess(S().inviteLinkCopied);
  }

  @override
  Widget build(BuildContext context) {
    final scheme = context.colorScheme;

    return AppCard(
      child: Row(
        children: [
          Expanded(
            child: Text(
              url,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 12.5.sp, color: scheme.onSurface),
            ),
          ),
          SizedBox(width: 8.w),
          GestureDetector(
            onTap: () => _copy(context),
            child: Padding(
              padding: EdgeInsets.all(4.r),
              child: Icon(Icons.copy_rounded, size: 20.r, color: context.semantic.accentStrong),
            ),
          ),
        ],
      ),
    );
  }
}
