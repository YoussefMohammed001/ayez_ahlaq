import 'package:equatable/equatable.dart';

class MoneyPinResetStatus extends Equatable {
  final bool pending;
  final String? lastStatus;
  final String? lastResolution;
  final String? lastAdminNote;
  final DateTime? lastRequestedAt;

  const MoneyPinResetStatus({
    required this.pending,
    this.lastStatus,
    this.lastResolution,
    this.lastAdminNote,
    this.lastRequestedAt,
  });

  @override
  List<Object?> get props => [
    pending,
    lastStatus,
    lastResolution,
    lastAdminNote,
    lastRequestedAt,
  ];
}
