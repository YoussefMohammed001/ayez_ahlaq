import 'package:equatable/equatable.dart';
import 'attendance_feature_request_status.dart';

class AttendanceFeatureRequest extends Equatable {
  final int? id;
  final AttendanceFeatureRequestStatus status;
  final num? price;
  final DateTime? createdAt;
  final DateTime? decidedAt;
  final String? note;

  const AttendanceFeatureRequest({
    required this.id,
    required this.status,
    required this.price,
    required this.createdAt,
    required this.decidedAt,
    required this.note,
  });

  @override
  List<Object?> get props => [id, status, price, createdAt, decidedAt, note];
}
