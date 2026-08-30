import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'nav_tab_item.dart';
import '../../core/extensions/ext_theme.dart';

class AppBottomNavBar extends StatelessWidget {
  final List<NavTabItem> items;
  final int currentIndex;
  final ValueChanged<int> onTap;

  const AppBottomNavBar({
    super.key,
    required this.items,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(6.w, 10.h, 6.w, 10.h),
      decoration: BoxDecoration(
        color: context.colorScheme.surfaceContainer,
        border: Border(top: BorderSide(color: context.colorScheme.outline)),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            for (var i = 0; i < items.length; i++)
              Expanded(child: _buildTab(context, i)),
          ],
        ),
      ),
    );
  }

  Widget _buildTab(BuildContext context, int index) {
    final selected = index == currentIndex;
    final color = selected ? context.semantic.accentStrong : context.colorScheme.onSurfaceVariant;

    return InkWell(
      onTap: () => onTap(index),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 6.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(items[index].icon, size: 22.r, color: color),
            SizedBox(height: 4.h),
            Text(
              items[index].label,
              style: TextStyle(
                fontSize: 10.5.sp,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
