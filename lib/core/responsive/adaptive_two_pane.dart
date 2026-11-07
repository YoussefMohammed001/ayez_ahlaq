import 'package:flutter/material.dart';
import 'window_size.dart';

class AdaptiveTwoPane extends StatelessWidget {
  static const double gap = 24;

  final Widget leading;
  final Widget trailing;

  const AdaptiveTwoPane({
    super.key,
    required this.leading,
    required this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    if (!context.windowSize.isExpanded) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [leading, trailing],
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: leading),
        const SizedBox(width: gap),
        Expanded(child: trailing),
      ],
    );
  }
}
