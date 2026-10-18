import 'package:equatable/equatable.dart';

class HomeServiceBroadcast extends Equatable {
  final int candidateId;
  final int requestId;
  final String requestCode;
  final String candidateStatus;
  final String requestStatus;
  final String address;
  final double? distanceKm;
  final String? note;
  final String date;
  final String time;
  final num? suggestedPrice;
  final String? expiresAt;

  const HomeServiceBroadcast({
    required this.candidateId,
    required this.requestId,
    required this.requestCode,
    required this.candidateStatus,
    required this.requestStatus,
    required this.address,
    this.distanceKm,
    this.note,
    required this.date,
    required this.time,
    this.suggestedPrice,
    this.expiresAt,
  });

  bool get isPending => candidateStatus == 'PENDING';

  @override
  List<Object?> get props => [
    candidateId,
    requestId,
    requestCode,
    candidateStatus,
    requestStatus,
    address,
    distanceKm,
    note,
    date,
    time,
    suggestedPrice,
    expiresAt,
  ];
}
