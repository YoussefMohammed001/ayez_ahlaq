import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:ayez_ahlaq/core/extensions/ext.dart';
import 'package:ayez_ahlaq/core/theme/styles.dart';
import 'package:ayez_ahlaq/core/widgets/app_button.dart';
import 'package:ayez_ahlaq/generated/l10n.dart';

class SuccessScreen extends StatefulWidget {
  const SuccessScreen({super.key, required this.message});

  final String message;

  @override
  State<SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen>
    with TickerProviderStateMixin {
  late final AnimationController _circleController;
  late final AnimationController _checkController;
  late final AnimationController _fadeController;

  late final Animation<double> _circleScale;
  late final Animation<double> _checkProgress;
  late final Animation<double> _fadeIn;
  late final Animation<double> _particleProgress;

  @override
  void initState() {
    super.initState();

    _circleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _checkController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _circleScale = CurvedAnimation(
      parent: _circleController,
      curve: Curves.elasticOut,
    );

    _checkProgress = CurvedAnimation(
      parent: _checkController,
      curve: Curves.easeOutCubic,
    );

    _particleProgress = CurvedAnimation(
      parent: _checkController,
      curve: Curves.easeOut,
    );

    _fadeIn = CurvedAnimation(parent: _fadeController, curve: Curves.easeIn);

    _runSequence();
  }

  Future<void> _runSequence() async {
    await Future.delayed(const Duration(milliseconds: 200));
    await _circleController.forward();
    await Future.delayed(const Duration(milliseconds: 100));
    await _checkController.forward();
    await Future.delayed(const Duration(milliseconds: 100));
    await _fadeController.forward();
  }

  @override
  void dispose() {
    _circleController.dispose();
    _checkController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 32.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(flex: 2),
              AnimatedBuilder(
                animation: Listenable.merge([
                  _circleController,
                  _checkController,
                ]),
                builder: (context, _) {
                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      // Particles
                      SizedBox(
                        width: 200.r,
                        height: 200.r,
                        child: CustomPaint(
                          painter: _ParticlePainter(
                            progress: _particleProgress.value,
                            color: colorScheme.primary,
                          ),
                        ),
                      ),
                      // Circle
                      ScaleTransition(
                        scale: _circleScale,
                        child: Container(
                          width: 120.r,
                          height: 120.r,
                          decoration: BoxDecoration(
                            color: colorScheme.primary.withValues(alpha: 0.1),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      // Check icon
                      ScaleTransition(
                        scale: _circleScale,
                        child: Container(
                          width: 90.r,
                          height: 90.r,
                          decoration: BoxDecoration(
                            color: colorScheme.primary,
                            shape: BoxShape.circle,
                          ),
                          child: CustomPaint(
                            painter: _CheckPainter(
                              progress: _checkProgress.value,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
              40.hSpace,
              FadeTransition(
                opacity: _fadeIn,
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0, 0.3),
                    end: Offset.zero,
                  ).animate(_fadeIn),
                  child: Column(
                    children: [
                      Text(
                        widget.message,
                        textAlign: TextAlign.center,
                        style: font18w700.copyWith(
                          color: colorScheme.onSurface,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Spacer(flex: 3),
              FadeTransition(
                opacity: _fadeIn,
                child: AppButton(
                  text: S().done,
                  onPressed: () => context.go('/mainScreen'),
                ),
              ),
              32.hSpace,
            ],
          ),
        ),
      ),
    );
  }
}

class _CheckPainter extends CustomPainter {
  const _CheckPainter({required this.progress, required this.color});

  final double progress;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    if (progress == 0) return;

    final paint = Paint()
      ..color = color
      ..strokeWidth = 4.0
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;

    final cx = size.width / 2;
    final cy = size.height / 2;

    // Check mark: from (cx-14, cy) → (cx-4, cy+10) → (cx+14, cy-10)
    final p1 = Offset(cx - 14, cy);
    final p2 = Offset(cx - 4, cy + 10);
    final p3 = Offset(cx + 14, cy - 10);

    final totalLength = (p2 - p1).distance + (p3 - p2).distance;
    final drawn = totalLength * progress;

    final seg1 = (p2 - p1).distance;

    final path = Path();
    if (drawn <= seg1) {
      final t = drawn / seg1;
      path.moveTo(p1.dx, p1.dy);
      path.lineTo(p1.dx + (p2.dx - p1.dx) * t, p1.dy + (p2.dy - p1.dy) * t);
    } else {
      final remaining = drawn - seg1;
      final t = remaining / (p3 - p2).distance;
      path.moveTo(p1.dx, p1.dy);
      path.lineTo(p2.dx, p2.dy);
      path.lineTo(p2.dx + (p3.dx - p2.dx) * t, p2.dy + (p3.dy - p2.dy) * t);
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_CheckPainter old) => old.progress != progress;
}

class _ParticlePainter extends CustomPainter {
  const _ParticlePainter({required this.progress, required this.color});

  final double progress;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    if (progress == 0) return;

    final paint = Paint()..style = PaintingStyle.fill;
    final cx = size.width / 2;
    final cy = size.height / 2;
    const particleCount = 8;
    const radius = 75.0;

    for (int i = 0; i < particleCount; i++) {
      final angle = (i / particleCount) * 2 * math.pi;
      final dist = radius * progress;
      final x = cx + dist * math.cos(angle);
      final y = cy + dist * math.sin(angle);
      final opacity = (1 - progress).clamp(0.0, 1.0);
      final particleRadius = (4.0 * (1 - progress * 0.5)).clamp(1.0, 5.0);

      paint.color = color.withValues(alpha: opacity);
      canvas.drawCircle(Offset(x, y), particleRadius, paint);
    }
  }

  @override
  bool shouldRepaint(_ParticlePainter old) => old.progress != progress;
}
