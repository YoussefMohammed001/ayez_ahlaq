import 'dart:io';
import 'package:flutter/material.dart';
import '../../../domain/entities/geo_point.dart';
import 'app_map_controller.dart';
import 'apple_map_view.dart';
import 'google_map_view.dart';

class AppMap extends StatefulWidget {
  final GeoPoint initialTarget;
  final double initialZoom;
  final AppMapController controller;
  final ValueChanged<GeoPoint> onCameraMove;
  final VoidCallback onCameraIdle;
  final ValueChanged<GeoPoint> onTap;

  const AppMap({
    super.key,
    required this.initialTarget,
    required this.controller,
    required this.onCameraMove,
    required this.onCameraIdle,
    required this.onTap,
    this.initialZoom = 16,
  });

  @override
  State<AppMap> createState() => _AppMapState();
}

class _AppMapState extends State<AppMap> {
  @override
  void dispose() {
    widget.controller.detach();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return AppleMapView(
        initialTarget: widget.initialTarget,
        initialZoom: widget.initialZoom,
        controller: widget.controller,
        onCameraMove: widget.onCameraMove,
        onCameraIdle: widget.onCameraIdle,
        onTap: widget.onTap,
      );
    }

    return GoogleMapView(
      initialTarget: widget.initialTarget,
      initialZoom: widget.initialZoom,
      controller: widget.controller,
      onCameraMove: widget.onCameraMove,
      onCameraIdle: widget.onCameraIdle,
      onTap: widget.onTap,
    );
  }
}
