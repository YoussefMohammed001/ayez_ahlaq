import 'package:apple_maps_flutter/apple_maps_flutter.dart' as apple;
import 'package:flutter/material.dart';
import '../../../domain/entities/geo_point.dart';
import 'app_map_controller.dart';

class AppleMapView extends StatelessWidget {
  final GeoPoint initialTarget;
  final double initialZoom;
  final AppMapController controller;
  final ValueChanged<GeoPoint> onCameraMove;
  final VoidCallback onCameraIdle;
  final ValueChanged<GeoPoint> onTap;

  const AppleMapView({
    super.key,
    required this.initialTarget,
    required this.initialZoom,
    required this.controller,
    required this.onCameraMove,
    required this.onCameraIdle,
    required this.onTap,
  });

  apple.LatLng _toLatLng(GeoPoint point) =>
      apple.LatLng(point.latitude, point.longitude);

  void _onCreated(apple.AppleMapController map) {
    controller.attach(
      animator: (point, zoom) => map.animateCamera(
        zoom == null
            ? apple.CameraUpdate.newLatLng(_toLatLng(point))
            : apple.CameraUpdate.newLatLngZoom(_toLatLng(point), zoom),
      ),
      zoomer: (delta) => map.animateCamera(apple.CameraUpdate.zoomBy(delta)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return apple.AppleMap(
      initialCameraPosition: apple.CameraPosition(
        target: _toLatLng(initialTarget),
        zoom: initialZoom,
      ),
      onMapCreated: _onCreated,
      onCameraMove: (position) => onCameraMove(
        GeoPoint(position.target.latitude, position.target.longitude),
      ),
      onCameraIdle: onCameraIdle,
      onTap: (position) =>
          onTap(GeoPoint(position.latitude, position.longitude)),
      compassEnabled: false,
      rotateGesturesEnabled: false,
      pitchGesturesEnabled: false,
    );
  }
}
