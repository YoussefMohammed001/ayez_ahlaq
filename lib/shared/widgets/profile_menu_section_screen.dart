import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ayez_ahlaq/core/widgets/app_top_bar.dart';
import 'package:ayez_ahlaq/core/widgets/menu_row.dart';

class ProfileMenuSectionScreen extends StatelessWidget {
  final String title;
  final List<MenuRow> rows;

  const ProfileMenuSectionScreen({
    super.key,
    required this.title,
    required this.rows,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppTopBar(title: title),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainer,
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: Theme.of(context).colorScheme.outline),
            ),
            child: Column(
              children: [
                for (final (index, row) in rows.indexed)
                  index == rows.length - 1 ? row.withoutDivider() : row,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
