import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'nav_tab_item.dart';
import '../../core/extensions/ext_theme.dart';

class FlatBottomNavBar extends StatelessWidget {
  final List<NavTabItem> items;
  final int currentIndex;
  final ValueChanged<int> onTap;
  final Widget Function(int index, Widget tab)? tabBuilder;

  const FlatBottomNavBar({
    super.key,
    required this.items,
    required this.currentIndex,
    required this.onTap,
    this.tabBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: context.colorScheme.surfaceContainer,
      padding: EdgeInsets.zero,
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 64.h,
          child: Row(
            children: [
              for (var i = 0; i < items.length; i++) Expanded(child: _buildTab(context, i)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTab(BuildContext context, int index) {
    final selected = index == currentIndex;
    final color = selected ? context.semantic.accentStrong : context.colorScheme.onSurfaceVariant;

    final tab = InkWell(
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

    return tabBuilder?.call(index, tab) ?? tab;
  }
}
