import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../core/theme/heading_styles.dart';
import '../../../../../generated/l10n.dart';

class EditBillTitle extends StatelessWidget {
  const EditBillTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.receipt_long_outlined,
          size: 22.r,
          color: context.semantic.accentStrong,
        ),
        SizedBox(width: 8.w),
        Text(S().editBillTitle, style: HeadingStyles.h4),
      ],
    );
  }
}
