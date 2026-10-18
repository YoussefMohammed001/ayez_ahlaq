import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../routes/app_routes.dart';

class LoadingOverlay {
  LoadingOverlay._();

  static bool _requested = false;
  static DialogRoute<void>? _route;

  static Future<void> show({bool canDismiss = false}) {
    if (_requested) return Future.value();
    _requested = true;

    final presented = Completer<void>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _present(canDismiss);
      presented.complete();
    });
    WidgetsBinding.instance.ensureVisualUpdate();
    return presented.future;
  }

  static void hide() {
    _requested = false;
    final route = _route;
    _route = null;
    if (route != null && route.isActive) {
      rootNavigatorKey.currentState?.removeRoute(route);
    }
  }

  static void _present(bool canDismiss) {
    final navigator = rootNavigatorKey.currentState;
    if (navigator == null) {
      _requested = false;
      return;
    }
    if (!_requested) return;

    final route = DialogRoute<void>(
      context: navigator.context,
      barrierDismissible: canDismiss,
      builder: (context) => Center(
        child: SpinKitDualRing(
          color: Theme.of(context).primaryColor,
          size: 50.h,
        ),
      ),
    );
    _route = route;
    navigator.push(route).whenComplete(() {
      if (!identical(_route, route)) return;
      _route = null;
      _requested = false;
    });
  }
}
