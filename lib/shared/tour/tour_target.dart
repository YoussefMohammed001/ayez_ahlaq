import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:showcaseview/showcaseview.dart';
import '../../core/extensions/ext_theme.dart';
import '../../generated/l10n.dart';
import 'tour_target_registry.dart';

class TourTarget extends StatefulWidget {
  final GlobalKey tourKey;
  final String title;
  final String description;
  final bool isLast;
  final BorderRadius? borderRadius;
  final Widget child;

  const TourTarget({
    super.key,
    required this.tourKey,
    required this.title,
    required this.description,
    required this.child,
    this.isLast = false,
    this.borderRadius,
  });

  @override
  State<TourTarget> createState() => _TourTargetState();
}

class _TourTargetState extends State<TourTarget> {
  @override
  void initState() {
    super.initState();
    TourTargetRegistry.add(widget.tourKey);
  }

  @override
  void didUpdateWidget(TourTarget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.tourKey == widget.tourKey) return;
    TourTargetRegistry.remove(oldWidget.tourKey);
    TourTargetRegistry.add(widget.tourKey);
  }

  @override
  void dispose() {
    TourTargetRegistry.remove(widget.tourKey);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = context.colorScheme;

    return Showcase(
      key: widget.tourKey,
      title: widget.title,
      description: widget.description,
      titleTextStyle: TextStyle(
        fontSize: 15.sp,
        fontWeight: FontWeight.w800,
        color: scheme.onSurface,
      ),
      descTextStyle: TextStyle(
        fontSize: 13.sp,
        height: 1.6,
        color: scheme.onSurfaceVariant,
      ),
      tooltipBackgroundColor: scheme.surfaceContainer,
      textColor: scheme.onSurface,
      targetBorderRadius: widget.borderRadius ?? BorderRadius.circular(14.r),
      targetPadding: EdgeInsets.all(4.r),
      tooltipPadding: EdgeInsets.all(12.r),
      disableMovingAnimation: true,
      disableScaleAnimation: true,
      tooltipActionConfig: const TooltipActionConfig(
        alignment: MainAxisAlignment.spaceBetween,
        position: TooltipActionPosition.inside,
        gapBetweenContentAndAction: 12,
      ),
      tooltipActions: [
        if (!widget.isLast)
          TooltipActionButton(
            type: TooltipDefaultActionType.skip,
            name: S().tourSkip,
            textStyle: TextStyle(
              fontSize: 12.sp,
              color: scheme.onSurfaceVariant,
            ),
            backgroundColor: Colors.transparent,
          ),
        TooltipActionButton(
          type: TooltipDefaultActionType.next,
          name: widget.isLast ? S().tourDone : S().tourNext,
          textStyle: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w700,
            color: scheme.onPrimary,
          ),
          backgroundColor: scheme.primary,
        ),
      ],
      child: widget.child,
    );
  }
}
