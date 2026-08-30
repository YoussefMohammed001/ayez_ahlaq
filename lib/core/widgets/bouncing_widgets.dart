import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show HapticFeedback;

class BounceIt extends StatefulWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final Duration duration;
  final bool hapticFeedback;
  final String? semanticLabel;

  const BounceIt({
    required this.child,
    super.key,
    this.onPressed,
    this.duration = const Duration(milliseconds: 100),
    this.hapticFeedback = true,
    this.semanticLabel,
  });

  @override
  BounceItState createState() => BounceItState();
}

class BounceItState extends State<BounceIt>
    with SingleTickerProviderStateMixin {
  late double _scale;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
      lowerBound: 0.0,
      upperBound: 0.1,
    );
    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _scale = 1 - _controller.value;

    final tappable = Listener(
      onPointerDown: (PointerDownEvent event) {
        _controller.forward();
      },
      onPointerUp: (PointerUpEvent event) {
        _controller.reverse();
      },
      child: InkWell(
        onTap: widget.onPressed == null
            ? null
            : () {
                if (widget.hapticFeedback) HapticFeedback.lightImpact();
                widget.onPressed!();
              },
        focusColor: Colors.transparent,
        hoverColor: Colors.transparent,
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        child: Transform.scale(scale: _scale, child: widget.child),
      ),
    );

    if (widget.semanticLabel == null) return tappable;
    return Semantics(
      button: true,
      label: widget.semanticLabel,
      child: tappable,
    );
  }
}
