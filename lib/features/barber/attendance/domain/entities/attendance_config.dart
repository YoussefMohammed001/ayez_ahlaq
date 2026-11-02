import 'package:equatable/equatable.dart';

class AttendanceConfig extends Equatable {
  final double? shopLat;
  final double? shopLng;
  final int? rangeMeters;
  final bool enforced;

  const AttendanceConfig({
    required this.shopLat,
    required this.shopLng,
    required this.rangeMeters,
    required this.enforced,
  });

  const AttendanceConfig.none()
    : shopLat = null,
      shopLng = null,
      rangeMeters = null,
      enforced = false;

  @override
  List<Object?> get props => [shopLat, shopLng, rangeMeters, enforced];
}
