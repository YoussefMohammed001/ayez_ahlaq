import '../../../domain/entities/geo_point.dart';

typedef MapAnimator = void Function(GeoPoint point, double? zoom);
typedef MapZoomer = void Function(double delta);

class AppMapController {
  MapAnimator? _animator;
  MapZoomer? _zoomer;
  ({GeoPoint point, double? zoom})? _pending;

  void attach({required MapAnimator animator, required MapZoomer zoomer}) {
    _animator = animator;
    _zoomer = zoomer;
    final pending = _pending;
    if (pending == null) return;
    _pending = null;
    animator(pending.point, pending.zoom);
  }

  void detach() {
    _animator = null;
    _zoomer = null;
  }

  void animateTo(GeoPoint point, {double? zoom = 16}) {
    final animator = _animator;
    if (animator == null) {
      _pending = (point: point, zoom: zoom);
      return;
    }
    animator(point, zoom);
  }

  void panTo(GeoPoint point) => animateTo(point, zoom: null);

  void zoomIn() => _zoomer?.call(1);

  void zoomOut() => _zoomer?.call(-1);
}
