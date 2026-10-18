import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/extensions/ext_theme.dart';
import '../../domain/entities/geo_point.dart';
import 'map/app_map.dart';
import 'map/app_map_controller.dart';
import 'map_my_location_button.dart';
import 'map_picker_center_pin.dart';
import 'map_zoom_buttons.dart';

class MapPickerMapCard extends StatelessWidget {
  final GeoPoint initialTarget;
  final double initialZoom;
  final AppMapController controller;
  final ValueChanged<GeoPoint> onCameraMove;
  final VoidCallback onCameraIdle;
  final VoidCallback onMyLocation;

  const MapPickerMapCard({
    super.key,
    required this.initialTarget,
    required this.initialZoom,
    required this.controller,
    required this.onCameraMove,
    required this.onCameraIdle,
    required this.onMyLocation,
  });

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(20.r);

    return Container(
      decoration: BoxDecoration(
        borderRadius: radius,
        border: Border.all(color: context.colorScheme.outline),
      ),
      child: ClipRRect(
        borderRadius: radius,
        child: Stack(
          children: [
            AppMap(
              initialTarget: initialTarget,
              initialZoom: initialZoom,
              controller: controller,
              onCameraMove: onCameraMove,
              onCameraIdle: onCameraIdle,
              onTap: controller.panTo,
            ),
            const MapPickerCenterPin(),
            PositionedDirectional(
              end: 10.w,
              bottom: 10.h,
              child: MapMyLocationButton(onPressed: onMyLocation),
            ),
            PositionedDirectional(
              end: 10.w,
              top: 10.h,
              child: MapZoomButtons(
                onZoomIn: controller.zoomIn,
                onZoomOut: controller.zoomOut,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
