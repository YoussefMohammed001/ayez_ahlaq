import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'shimmer_box.dart';
import '../../core/extensions/ext_theme.dart';

class ListSkeleton extends StatelessWidget {
  final int itemCount;
  final bool showLeading;

  const ListSkeleton({super.key, this.itemCount = 5, this.showLeading = true});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 4.h),
      itemCount: itemCount,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (_, __) => Container(
        padding: EdgeInsets.all(12.w),
        margin: EdgeInsets.only(bottom: 10.h),
        decoration: BoxDecoration(
          color: context.colorScheme.surfaceContainer,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: context.colorScheme.outline),
        ),
        child: Row(
          children: [
            if (showLeading) ...[
              ShimmerBox(width: 54.r, height: 54.r, radius: 12.r),
              SizedBox(width: 12.w),
            ],
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShimmerBox(width: 150.w),
                  SizedBox(height: 8.h),
                  ShimmerBox(width: 100.w, height: 11.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
