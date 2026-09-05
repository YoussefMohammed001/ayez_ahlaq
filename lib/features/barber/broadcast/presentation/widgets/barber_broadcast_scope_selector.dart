import 'package:flutter/material.dart';
import '../../../../../generated/l10n.dart';
import '../manager/barber_broadcast_state.dart';

class BarberBroadcastScopeSelector extends StatelessWidget {
  final BarberBroadcastScope scope;
  final ValueChanged<BarberBroadcastScope> onChanged;

  const BarberBroadcastScopeSelector({
    super.key,
    required this.scope,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<BarberBroadcastScope>(
      segments: [
        ButtonSegment(
          value: BarberBroadcastScope.all,
          label: Text(S().broadcastScopeAll),
        ),
        ButtonSegment(
          value: BarberBroadcastScope.mine,
          label: Text(S().broadcastScopeMine),
        ),
      ],
      selected: {scope},
      onSelectionChanged: (selection) => onChanged(selection.first),
    );
  }
}
