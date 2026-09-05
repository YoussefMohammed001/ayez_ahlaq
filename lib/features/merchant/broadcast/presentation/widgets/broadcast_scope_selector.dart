import 'package:flutter/material.dart';
import '../../../../../generated/l10n.dart';
import '../manager/merchant_broadcast_state.dart';

class BroadcastScopeSelector extends StatelessWidget {
  final MerchantBroadcastScope scope;
  final String? zoneName;
  final ValueChanged<MerchantBroadcastScope> onChanged;

  const BroadcastScopeSelector({
    super.key,
    required this.scope,
    required this.zoneName,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<MerchantBroadcastScope>(
      segments: [
        ButtonSegment(
          value: MerchantBroadcastScope.all,
          label: Text(S().broadcastScopeAll),
        ),
        ButtonSegment(
          value: MerchantBroadcastScope.zone,
          label: Text(zoneName ?? S().broadcastScopeZone),
        ),
      ],
      selected: {scope},
      onSelectionChanged: (selection) => onChanged(selection.first),
    );
  }
}
