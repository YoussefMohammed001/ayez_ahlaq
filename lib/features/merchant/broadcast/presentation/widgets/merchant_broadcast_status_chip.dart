import 'package:flutter/material.dart';
import '../../../../../core/widgets/badge_tone.dart';
import '../../../../../core/widgets/status_badge.dart';
import '../../../../../generated/l10n.dart';
import '../../domain/entities/broadcast_status.dart';

class MerchantBroadcastStatusChip extends StatelessWidget {
  final BroadcastStatus status;

  const MerchantBroadcastStatusChip({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    return StatusBadge(label: _label, tone: _tone);
  }

  String get _label => switch (status) {
    BroadcastStatus.pending => S().broadcastStatusPending,
    BroadcastStatus.approved => S().broadcastStatusApproved,
    BroadcastStatus.rejected => S().broadcastStatusRejected,
    BroadcastStatus.other => S().broadcastStatusPending,
  };

  BadgeTone get _tone => switch (status) {
    BroadcastStatus.pending => BadgeTone.closed,
    BroadcastStatus.approved => BadgeTone.open,
    BroadcastStatus.rejected => BadgeTone.danger,
    BroadcastStatus.other => BadgeTone.closed,
  };
}
