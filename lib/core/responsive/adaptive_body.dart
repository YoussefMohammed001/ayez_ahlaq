import 'package:flutter/material.dart';
import 'window_size.dart';

class AdaptiveBody extends StatelessWidget {
  static const double mediumWidth = 720;
  static const double expandedWidth = 1100;

  final Widget child;
  final bool narrow;

  const AdaptiveBody({super.key, required this.child}) : narrow = false;

  const AdaptiveBody.narrow({super.key, required this.child}) : narrow = true;

  @override
  Widget build(BuildContext context) {
    final size = context.windowSize;
    if (size.isCompact) return child;

    return Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: !narrow && size.isExpanded ? expandedWidth : mediumWidth,
        ),
        child: child,
      ),
    );
  }
}
