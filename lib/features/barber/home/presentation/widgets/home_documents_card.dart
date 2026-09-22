import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/app_card.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../generated/l10n.dart';

class HomeDocumentsCard extends StatelessWidget {
  final int missingCount;
  final VoidCallback onTap;

  const HomeDocumentsCard({
    super.key,
    required this.missingCount,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    if (missingCount == 0) return const SizedBox.shrink();

    final scheme = context.colorScheme;
    final warning = context.semantic.warning;

    return AppCard(
      onTap: onTap,
      borderColor: warning,
      child: Row(
        children: [
          Icon(Icons.description_outlined, color: warning, size: 20.r),
          SizedBox(width: 10.w),
          Expanded(
            child: Text(
              S().missingDocumentsHomeCount(missingCount),
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w700,
                color: scheme.onSurface,
              ),
            ),
          ),
          Icon(Icons.chevron_right, color: scheme.onSurfaceVariant, size: 20.r),
        ],
      ),
    );
  }
}
