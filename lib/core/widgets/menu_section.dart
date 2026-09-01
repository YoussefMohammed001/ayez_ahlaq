import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'menu_row.dart';
import 'section_title.dart';
import '../../core/extensions/ext_theme.dart';

class MenuSection extends StatelessWidget {
  final String title;
  final List<MenuRow> children;

  const MenuSection({super.key, required this.title, required this.children});

  List<Widget> _withoutTrailingDivider() {
    return [
      for (final (index, row) in children.indexed)
        if (index == children.length - 1) row.withoutDivider() else row,
    ];
  }

  @override
  Widget build(BuildContext context) {
    if (children.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(title: title),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          decoration: BoxDecoration(
            color: context.colorScheme.surfaceContainer,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: context.colorScheme.outline),
          ),
          child: Column(children: _withoutTrailingDivider()),
        ),
      ],
    );
  }
}
