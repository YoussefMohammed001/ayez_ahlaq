import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as google;
import '../../../domain/entities/geo_point.dart';
import 'app_map_controller.dart';

class GoogleMapView extends StatelessWidget {
  final GeoPoint initialTarget;
  final double initialZoom;
  final AppMapController controller;
  final ValueChanged<GeoPoint> onCameraMove;
  final VoidCallback onCameraIdle;
  final ValueChanged<GeoPoint> onTap;

  const GoogleMapView({
    super.key,
    required this.initialTarget,
    required this.initialZoom,
    required this.controller,
    required this.onCameraMove,
    required this.onCameraIdle,
    required this.onTap,
  });

  google.LatLng _toLatLng(GeoPoint point) =>
      google.LatLng(point.latitude, point.longitude);

  void _onCreated(google.GoogleMapController map) {
    controller.attach(
      animator: (point, zoom) => map.animateCamera(
        zoom == null
            ? google.CameraUpdate.newLatLng(_toLatLng(point))
            : google.CameraUpdate.newLatLngZoom(_toLatLng(point), zoom),
      ),
      zoomer: (delta) => map.animateCamera(google.CameraUpdate.zoomBy(delta)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return google.GoogleMap(
      initialCameraPosition: google.CameraPosition(
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
      myLocationButtonEnabled: false,
      zoomControlsEnabled: false,
      mapToolbarEnabled: false,
    );
  }
}
