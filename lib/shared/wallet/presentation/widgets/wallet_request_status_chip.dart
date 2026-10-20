import 'package:flutter/material.dart';
import '../../../../core/widgets/badge_tone.dart';
import '../../../../core/widgets/status_badge.dart';
import '../../../../generated/l10n.dart';
import '../../domain/entities/wallet_request_status.dart';

class WalletRequestStatusChip extends StatelessWidget {
  final WalletRequestStatus status;

  const WalletRequestStatusChip({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    return StatusBadge(label: _label, tone: _tone);
  }

  String get _label => switch (status) {
    WalletRequestStatus.pending => S().walletRequestStatusPending,
    WalletRequestStatus.approved => S().walletRequestStatusApproved,
    WalletRequestStatus.rejected => S().walletRequestStatusRejected,
    WalletRequestStatus.cancelled => S().walletRequestStatusCancelled,
    WalletRequestStatus.other => S().walletRequestStatusPending,
  };

  BadgeTone get _tone => switch (status) {
    WalletRequestStatus.pending => BadgeTone.gold,
    WalletRequestStatus.approved => BadgeTone.open,
    WalletRequestStatus.rejected => BadgeTone.danger,
    WalletRequestStatus.cancelled => BadgeTone.muted,
    WalletRequestStatus.other => BadgeTone.gold,
  };
}
