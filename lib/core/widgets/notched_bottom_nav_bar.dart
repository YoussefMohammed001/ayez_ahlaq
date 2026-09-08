import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'nav_tab_item.dart';
import '../../core/extensions/ext_theme.dart';

class NotchedBottomNavBar extends StatelessWidget {
  final List<NavTabItem> items;
  final int currentIndex;
  final ValueChanged<int> onTap;

  const NotchedBottomNavBar({
    super.key,
    required this.items,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final half = items.length ~/ 2;

    return BottomAppBar(
      color: context.colorScheme.surfaceContainer,
      shape: const CircularNotchedRectangle(),
      notchMargin: 8.r,
      padding: EdgeInsets.zero,
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 64.h,
          child: Row(
            children: [
              for (var i = 0; i < half; i++) Expanded(child: _buildTab(context, i)),
              SizedBox(width: 64.w),
              for (var i = half; i < items.length; i++) Expanded(child: _buildTab(context, i)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTab(BuildContext context, int index) {
    final selected = index == currentIndex;
    final color = selected ? context.semantic.accentStrong : context.colorScheme.onSurfaceVariant;

    return InkWell(
      onTap: () => onTap(index),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(items[index].icon, size: 22.r, color: color),
          SizedBox(height: 4.h),
          Text(
            items[index].label,
            style: TextStyle(fontSize: 10.5.sp, fontWeight: FontWeight.w600, color: color),
          ),
        ],
      ),
    );
  }
}
