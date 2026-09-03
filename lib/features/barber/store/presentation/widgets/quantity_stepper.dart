import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/extensions/ext_theme.dart';

class QuantityStepper extends StatelessWidget {
  final int quantity;
  final int minQuantity;
  final ValueChanged<int> onChanged;

  const QuantityStepper({
    super.key,
    required this.quantity,
    required this.onChanged,
    this.minQuantity = 1,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = context.colorScheme;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildButton(
          context,
          icon: Icons.remove_rounded,
          onTap: quantity <= 0
              ? null
              : () => onChanged(quantity - 1 < minQuantity ? 0 : quantity - 1),
        ),
        SizedBox(
          width: 32.w,
          child: Text(
            '$quantity',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: scheme.onSurface,
              fontWeight: FontWeight.w700,
              fontSize: 13.5.sp,
            ),
          ),
        ),
        _buildButton(
          context,
          icon: Icons.add_rounded,
          onTap: () => onChanged(quantity < minQuantity ? minQuantity : quantity + 1),
        ),
      ],
    );
  }

  Widget _buildButton(
    BuildContext context, {
    required IconData icon,
    required VoidCallback? onTap,
  }) {
    final scheme = context.colorScheme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8.r),
      child: Container(
        width: 28.r,
        height: 28.r,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: scheme.surfaceContainer,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: scheme.outline),
        ),
        child: Icon(
          icon,
          size: 16.r,
          color: onTap == null ? scheme.onSurfaceVariant.withValues(alpha: 0.4) : scheme.onSurface,
        ),
      ),
    );
  }
}
