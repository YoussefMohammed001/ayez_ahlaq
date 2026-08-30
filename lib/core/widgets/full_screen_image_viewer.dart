import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ayez_ahlaq/core/extensions/ext.dart';
import 'package:ayez_ahlaq/core/theme/styles.dart';
import 'package:ayez_ahlaq/core/widgets/app_image.dart';

class FullScreenImageViewer extends StatefulWidget {
  final String imageUrl;
  final String? title;
  final String? desc;

  const FullScreenImageViewer({
    super.key,
    required this.imageUrl,
    this.title,
    this.desc,
  });

  @override
  State<FullScreenImageViewer> createState() => _FullScreenImageViewerState();
}

class _FullScreenImageViewerState extends State<FullScreenImageViewer>
    with SingleTickerProviderStateMixin {
  final TransformationController _transformationController =
      TransformationController();

  late AnimationController _animationController;
  Animation<Matrix4>? _animation;

  double _currentScale = 1.0;
  bool _showZoomIndicator = false;
  bool _isZoomed = false;

  double _dragOffset = 0.0;
  bool _isDragging = false;

  @override
  void initState() {
    super.initState();

    _animationController =
        AnimationController(
          vsync: this,
          duration: const Duration(milliseconds: 250),
        )..addListener(() {
          if (_animation != null) {
            _transformationController.value = _animation!.value;
          }
        });

    _transformationController.addListener(_onTransformChanged);
  }

  @override
  void dispose() {
    _transformationController.removeListener(_onTransformChanged);
    _transformationController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _onTransformChanged() {
    final scale = _transformationController.value.getMaxScaleOnAxis();

    if ((scale - _currentScale).abs() > 0.05) {
      setState(() {
        _currentScale = scale;
        _isZoomed = scale > 1.05;
        _showZoomIndicator = true;
      });

      _hideZoomIndicatorAfterDelay();
    }
  }

  void _hideZoomIndicatorAfterDelay() {
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() => _showZoomIndicator = false);
      }
    });
  }

  void _onDoubleTapDown(TapDownDetails details) {
    if (_isZoomed) {
      _animateTo(Matrix4.identity());
    } else {
      final position = details.localPosition;

      const zoomFactor = 2.5;

      final x = -position.dx * (zoomFactor - 1);
      final y = -position.dy * (zoomFactor - 1);

      final zoomed = Matrix4.identity()
        ..translate(x, y)
        ..scale(zoomFactor);

      _animateTo(zoomed);
    }
  }

  void _animateTo(Matrix4 target) {
    _animation =
        Matrix4Tween(
          begin: _transformationController.value,
          end: target,
        ).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeInOut,
          ),
        );

    _animationController.forward(from: 0);
  }

  void _onVerticalDragUpdate(DragUpdateDetails details) {
    if (_isZoomed) return;

    setState(() {
      _isDragging = true;
      _dragOffset += details.delta.dy;
    });
  }

  void _onVerticalDragEnd(DragEndDetails details) {
    if (_isZoomed) return;

    if (_dragOffset.abs() > 100 ||
        details.primaryVelocity != null &&
            details.primaryVelocity!.abs() > 600) {
      Navigator.of(context).pop();
    } else {
      setState(() {
        _dragOffset = 0;
        _isDragging = false;
      });
    }
  }

  double get _backgroundOpacity {
    if (!_isDragging) return 1.0;
    return (1.0 - (_dragOffset.abs() / 300)).clamp(0.3, 1.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: GestureDetector(
        onVerticalDragUpdate: _onVerticalDragUpdate,
        onVerticalDragEnd: _onVerticalDragEnd,
        child: AnimatedContainer(
          duration: _isDragging
              ? Duration.zero
              : const Duration(milliseconds: 200),
          color: Colors.black.withValues(alpha: _backgroundOpacity),
          child: Transform.translate(
            offset: Offset(0, _dragOffset),
            child: Stack(
              children: [
                GestureDetector(
                  onDoubleTapDown: _onDoubleTapDown,
                  onDoubleTap: () {},
                  child: Center(
                    child: InteractiveViewer(
                      transformationController: _transformationController,
                      minScale: 1,
                      maxScale: 5,
                      onInteractionStart: (_) {
                        setState(() => _isDragging = false);
                      },
                      child: AppImage(
                        imageUrl: widget.imageUrl,
                        fit: BoxFit.contain,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                    ),
                  ),
                ),

                /// close button
                SafeArea(
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: EdgeInsets.all(12.h),
                      child: GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          padding: EdgeInsets.all(8.h),
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.6),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 24.h,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                /// zoom indicator
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 200),
                  top: _showZoomIndicator ? 60 : 20,
                  left: 0,
                  right: 0,
                  child: AnimatedOpacity(
                    opacity: _showZoomIndicator ? 1 : 0,
                    duration: const Duration(milliseconds: 200),
                    child: Center(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 14.w,
                          vertical: 6.h,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.6),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          '${(_currentScale * 100).round()}%',
                          style: font13w600.copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),

                /// title + description
                if (widget.title != null && widget.title!.isNotEmpty)
                  Positioned(
                    bottom: 50,
                    left: 0,
                    right: 0,
                    child: SafeArea(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 12.h,
                        ),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              Colors.black.withValues(alpha: 0.7),
                              Colors.transparent,
                            ],
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              widget.title!,
                              style: font16w600.copyWith(color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                            if (widget.desc != null) ...[
                              10.hSpace,
                              Text(
                                widget.desc!,
                                style: font14w600.copyWith(color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ),

                /// swipe hint
                SafeArea(
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: EdgeInsets.all(16.h),
                      child: AnimatedOpacity(
                        opacity: !_isZoomed ? 0.5 : 0,
                        duration: const Duration(milliseconds: 300),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.swipe_down,
                              color: Colors.white,
                              size: 16.h,
                            ),
                            4.wSpace,
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void openFullScreenImage(
  BuildContext context, {
  required String imageUrl,
  String? title,
  String? desc,
}) async {
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  await Navigator.of(context).push(
    PageRouteBuilder(
      opaque: false,
      barrierColor: Colors.transparent,
      pageBuilder: (_, animation, __) {
        return FadeTransition(
          opacity: animation,
          child: FullScreenImageViewer(
            imageUrl: imageUrl,
            title: title,
            desc: desc,
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 200),
      reverseTransitionDuration: const Duration(milliseconds: 200),
    ),
  );

  await SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.manual,
    overlays: SystemUiOverlay.values,
  );
}
