import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dark_colors.dart';

class Decorations {
  static BoxDecoration topRoundedContainer(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return BoxDecoration(
      color: scheme.surface,
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(20.r),
        topLeft: Radius.circular(20.r),
      ),
    );
  }

  static BoxDecoration card(BuildContext context, {double? radius}) {
    final scheme = Theme.of(context).colorScheme;
    return BoxDecoration(
      color: scheme.surfaceContainer,
      borderRadius: BorderRadius.circular(radius ?? 14.r),
      border: Border.all(color: scheme.outline),
    );
  }

  static BoxDecoration raisedCard(BuildContext context, {double? radius}) {
    final scheme = Theme.of(context).colorScheme;
    return BoxDecoration(
      color: scheme.surfaceContainerHigh,
      borderRadius: BorderRadius.circular(radius ?? 14.r),
      border: Border.all(color: scheme.outline),
    );
  }

  static BoxDecoration pill(
    BuildContext context, {
    Color? color,
    Color? border,
  }) {
    final scheme = Theme.of(context).colorScheme;
    return BoxDecoration(
      color: color ?? scheme.surfaceContainer,
      borderRadius: BorderRadius.circular(100.r),
      border: Border.all(color: border ?? scheme.outline),
    );
  }

  static const BoxDecoration gradientContainer = BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [AppDarkColors.brass700, AppDarkColors.brass100],
    ),
  );

  static List<BoxShadow> get shadowLg => [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.65),
      blurRadius: 60,
      spreadRadius: -20,
      offset: const Offset(0, 24),
    ),
  ];
}
