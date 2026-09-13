import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/extensions/ext_theme.dart';
import '../../generated/l10n.dart';

class QuantityPickerChip {
  final Object id;
  final String label;
  final int quantity;
  final int price;
  final VoidCallback onRemove;

  const QuantityPickerChip({
    required this.id,
    required this.label,
    required this.quantity,
    required this.price,
    required this.onRemove,
  });
}

class QuantityPickerTrigger extends StatelessWidget {
  final List<QuantityPickerChip> chips;
  final VoidCallback onTap;

  const QuantityPickerTrigger({super.key, required this.chips, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final scheme = context.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnimatedSize(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          alignment: Alignment.topCenter,
          child: chips.isEmpty
              ? const SizedBox.shrink()
              : Padding(
                  padding: EdgeInsets.only(bottom: 8.h),
                  child: Wrap(
                    spacing: 6.w,
                    runSpacing: 6.h,
                    children: [
                      for (final chip in chips)
                        InputChip(
                          key: ValueKey(chip.id),
                          label: Text(
                            '${chip.quantity}× ${chip.label} · ${S().currencyEgp(chip.price * chip.quantity)}',
                            style: TextStyle(fontSize: 11.5.sp, color: scheme.onSurface),
                          ),
                          onDeleted: chip.onRemove,
                          backgroundColor: scheme.surfaceContainerHighest,
                          side: BorderSide(color: scheme.outline),
                        ),
                    ],
                  ),
                ),
        ),
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: scheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(color: scheme.outline),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    chips.isEmpty ? S().walkInPickerNoneSelected : S().walkInPickerAddMore,
                    style: TextStyle(fontSize: 13.sp, color: scheme.onSurfaceVariant),
                  ),
                ),
                Icon(Icons.chevron_right, size: 20.r, color: scheme.onSurfaceVariant),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
