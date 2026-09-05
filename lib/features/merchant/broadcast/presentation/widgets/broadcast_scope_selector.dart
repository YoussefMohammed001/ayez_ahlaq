import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../generated/l10n.dart';
import '../manager/merchant_broadcast_state.dart';

class BroadcastScopeSelector extends StatelessWidget {
  final MerchantBroadcastScope scope;
  final String? zoneName;
  final ValueChanged<MerchantBroadcastScope>? onChanged;

  const BroadcastScopeSelector({
    super.key,
    required this.scope,
    required this.zoneName,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SegmentedButton<MerchantBroadcastScope>(
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
          onSelectionChanged: onChanged == null
              ? null
              : (selection) => onChanged!(selection.first),
        ),
        if (onChanged == null) ...[
          SizedBox(height: 6.h),
          Text(
            S().broadcastZoneUnavailable,
            style: TextStyle(
              fontSize: 11.5.sp,
              color: context.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ],
    );
  }
}
