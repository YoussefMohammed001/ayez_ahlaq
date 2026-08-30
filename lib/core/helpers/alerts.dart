import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import '/core/routes/app_routes.dart';
import '/core/theme/styles.dart';

bool _isLoading = false;

Future<void> showLoading({bool canDismiss = false}) async {
  if (_isLoading) return;
  _isLoading = true;

  final completer = Completer<void>();
  WidgetsBinding.instance.addPostFrameCallback((_) {
    final context = rootNavigatorKey.currentState?.context;
    if (context == null) {
      completer.complete();
      return;
    }

    showDialog(
      context: context,
      barrierDismissible: canDismiss,
      builder: (context) {
        return Center(
          child: SpinKitDualRing(
            color: Theme.of(context).primaryColor,
            size: 50.h,
          ),
        );
      },
    );
    completer.complete();
  });

  return completer.future;
}

void hideLoading() {
  if (!_isLoading) return;
  _isLoading = false;

  final navigatorState = rootNavigatorKey.currentState;
  if (navigatorState == null) return;

  if (navigatorState.canPop()) {
    navigatorState.pop();
  }
}

void showSuccess(String message, {bool canDismiss = true}) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    _showAlert(
      message: message,
      canDismiss: canDismiss,
      alertType: AlertType.success,
    );
  });
}

void showWarning(String message, {bool canDismiss = true}) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    _showAlert(
      message: message,
      canDismiss: canDismiss,
      alertType: AlertType.warning,
    );
  });
}

void showError(String message, {bool canDismiss = true}) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    _showAlert(
      message: message,
      canDismiss: canDismiss,
      alertType: AlertType.error,
    );
  });
}

enum AlertType { success, warning, error }

void _showAlert({
  required String message,
  required bool canDismiss,
  required AlertType alertType,
}) {
  final context = rootNavigatorKey.currentState?.context;
  if (context == null) return;

  showDialog(
    context: context,
    barrierDismissible: canDismiss,
    barrierColor: Colors.transparent,
    builder: (context) {
      Future.delayed(const Duration(milliseconds: 2500), () {
        if (context.mounted) context.pop();
      });

      return _PillToastAlert(alertType: alertType, message: message);
    },
  );
}

class _PillToastAlert extends StatefulWidget {
  final AlertType alertType;
  final String message;

  const _PillToastAlert({required this.alertType, required this.message});

  @override
  State<_PillToastAlert> createState() => _PillToastAlertState();
}

class _PillToastAlertState extends State<_PillToastAlert>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _opacity;
  late final Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );
    _opacity = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _slide = Tween<Offset>(
      begin: const Offset(0, -0.4),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Color get _background => switch (widget.alertType) {
    AlertType.success => const Color(0xFFF2FCF6),
    AlertType.warning => const Color(0xFFFFFCF0),
    AlertType.error => const Color(0xFFFFF5F5),
  };

  Color get _border => switch (widget.alertType) {
    AlertType.success => const Color(0xFFB3EAC8),
    AlertType.warning => const Color(0xFFF5DFA0),
    AlertType.error => const Color(0xFFF4C1BE),
  };

  Color get _textColor => switch (widget.alertType) {
    AlertType.success => const Color(0xFF1A7A45),
    AlertType.warning => const Color(0xFF8A6000),
    AlertType.error => const Color(0xFFB02A2A),
  };

  Color get _dotColor => switch (widget.alertType) {
    AlertType.success => const Color(0xFF2DBF6A),
    AlertType.warning => const Color(0xFFD4A017),
    AlertType.error => const Color(0xFFE24B4A),
  };

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacity,
      child: SlideTransition(
        position: _slide,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 12.h),
            Material(
              color: Colors.transparent,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                decoration: BoxDecoration(
                  color: _background,
                  borderRadius: BorderRadius.circular(100.r),
                  border: Border.all(color: _border, width: 1),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 8.w,
                      height: 8.h,
                      decoration: BoxDecoration(
                        color: _dotColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                    8.horizontalSpace,
                    Expanded(
                      child: Text(
                        widget.message,
                        style: font14w400.copyWith(
                          color: _textColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
