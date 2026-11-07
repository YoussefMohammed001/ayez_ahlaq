import 'package:flutter/widgets.dart';

enum WindowSize {
  compact,
  medium,
  expanded;

  static const double mediumStart = 600;
  static const double expandedStart = 840;

  static WindowSize ofWidth(double width) {
    if (width >= expandedStart) return WindowSize.expanded;
    if (width >= mediumStart) return WindowSize.medium;
    return WindowSize.compact;
  }

  static WindowSize of(BuildContext context) =>
      ofWidth(MediaQuery.sizeOf(context).width);

  bool get isCompact => this == WindowSize.compact;

  bool get isTablet => this != WindowSize.compact;

  bool get isExpanded => this == WindowSize.expanded;
}

extension WindowSizeContext on BuildContext {
  WindowSize get windowSize => WindowSize.of(this);
}
