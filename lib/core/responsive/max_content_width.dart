import 'package:flutter/material.dart';

class MaxContentWidth extends StatelessWidget {
  static const double pageWidth = 640;

  final double maxWidth;
  final Widget child;

  const MaxContentWidth({
    super.key,
    this.maxWidth = pageWidth,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxWidth),
          child: child,
        ),
      ),
    );
  }
}
