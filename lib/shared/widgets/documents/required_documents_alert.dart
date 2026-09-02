import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/extensions/ext_theme.dart';
import '../../../core/theme/styles.dart';
import '../../../core/widgets/app_card.dart';
import '../../../generated/l10n.dart';

class RequiredDocumentsAlert extends StatelessWidget {
  final int requiredCount;
  final int optionalCount;
  final VoidCallback? onTap;

  const RequiredDocumentsAlert({
    super.key,
    this.requiredCount = 0,
    this.optionalCount = 0,
    this.onTap,
  });

  bool get _isUrgent => requiredCount > 0;

  int get _total => requiredCount + optionalCount;

  @override
  Widget build(BuildContext context) {
    if (_total <= 0) return const SizedBox.shrink();

    final tone = _isUrgent
        ? context.semantic.warning
        : context.semantic.accentStrong;

    return AppCard(
      onTap: onTap,
      margin: EdgeInsets.only(bottom: 8.h),
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      borderColor: tone.withValues(alpha: 0.5),
      child: Row(
        children: [
          Icon(Icons.folder_open_rounded, size: 18.r, color: tone),
          SizedBox(width: 10.w),
          Expanded(child: _buildText(context)),
          Text('$_total', style: font15w700.copyWith(color: tone)),
          if (onTap != null) ...[
            SizedBox(width: 4.w),
            Icon(
              Icons.chevron_right,
              size: 18.r,
              color: context.colorScheme.onSurfaceVariant,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildText(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _isUrgent
              ? S().documentsRequestedTitle
              : S().documentsOptionalTitle,
          style: font13w500.copyWith(color: context.colorScheme.onSurface),
        ),
        SizedBox(height: 2.h),
        Text(
          _isUrgent
              ? S().documentsRequestedMessage
              : S().documentsOptionalMessage,
          style: font12w400.copyWith(
            color: context.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}
