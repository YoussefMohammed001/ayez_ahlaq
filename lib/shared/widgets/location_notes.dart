import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/extensions/ext_theme.dart';
import '../../generated/l10n.dart';

class LocationNotes extends StatelessWidget {
  const LocationNotes({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S().locationNote,
          style: TextStyle(
            fontSize: 12.5.sp,
            height: 1.8,
            color: context.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}
