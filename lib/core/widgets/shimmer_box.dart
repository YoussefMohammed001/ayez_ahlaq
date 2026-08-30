import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import '../../core/extensions/ext_theme.dart';

class ShimmerBox extends StatelessWidget {
  final double? width;
  final double? height;
  final double? radius;

  const ShimmerBox({super.key, this.width, this.height, this.radius});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: context.colorScheme.surfaceContainer,
      highlightColor: context.colorScheme.surfaceContainerHighest,
      child: Container(
        width: width,
        height: height ?? 14.h,
        decoration: BoxDecoration(
          color: context.colorScheme.surfaceContainer,
          borderRadius: BorderRadius.circular(radius ?? 8.r),
        ),
      ),
    );
  }
}
