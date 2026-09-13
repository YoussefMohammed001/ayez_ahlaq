import 'package:flutter/material.dart';
import '../../../../../core/widgets/badge_tone.dart';
import '../../../../../core/widgets/status_badge.dart';
import '../../../../../generated/l10n.dart';

class BarberStatusBadge extends StatelessWidget {
  final bool available;

  const BarberStatusBadge({super.key, required this.available});

  @override
  Widget build(BuildContext context) {
    return StatusBadge(
      label: available ? S().barberAvailableNow : S().barberBusyNow,
      tone: available ? BadgeTone.open : BadgeTone.danger,
    );
  }
}
