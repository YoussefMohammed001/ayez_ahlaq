import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ayez_ahlaq/core/extensions/ext.dart';
import 'package:ayez_ahlaq/core/theme/styles.dart';
import 'package:ayez_ahlaq/generated/l10n.dart';

class OrWidget extends StatelessWidget {
  const OrWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 5.w,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        10.wSpace,
        Expanded(child: Divider(color: Color(0xFF757575))),
        Text(S().or, style: font14w600.copyWith(color: Color(0xFF757575))),
        Expanded(child: Divider(color: Color(0xFF757575))),
        10.wSpace,
      ],
    );
  }
}
