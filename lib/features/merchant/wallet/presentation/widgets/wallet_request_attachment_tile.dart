import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/app_card.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../generated/l10n.dart';

class WalletRequestAttachmentTile extends StatelessWidget {
  final String? attachmentName;
  final VoidCallback onTap;

  const WalletRequestAttachmentTile({
    super.key,
    required this.attachmentName,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      onTap: onTap,
      child: Row(
        children: [
          Icon(Icons.image_outlined, color: context.colorScheme.onSurfaceVariant),
          SizedBox(width: 10.w),
          Expanded(
            child: Text(
              attachmentName ?? S().walletRequestAttachmentLabel,
              style: TextStyle(fontSize: 13.sp, color: context.colorScheme.onSurface),
            ),
          ),
          Icon(Icons.chevron_right_rounded, color: context.colorScheme.onSurfaceVariant),
        ],
      ),
    );
  }
}
