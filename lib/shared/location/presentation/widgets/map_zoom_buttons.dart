import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/extensions/ext_theme.dart';

class MapZoomButtons extends StatelessWidget {
  final VoidCallback onZoomIn;
  final VoidCallback onZoomOut;

  const MapZoomButtons({
    super.key,
    required this.onZoomIn,
    required this.onZoomOut,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = context.colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: scheme.outline),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: onZoomIn,
            icon: Icon(Icons.add_rounded, size: 22.r, color: scheme.onSurface),
          ),
          Container(width: 28.w, height: 1, color: scheme.outline),
          IconButton(
            onPressed: onZoomOut,
            icon: Icon(
              Icons.remove_rounded,
              size: 22.r,
              color: scheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}
