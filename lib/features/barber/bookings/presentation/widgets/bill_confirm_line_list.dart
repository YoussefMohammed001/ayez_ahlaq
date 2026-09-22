import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../core/theme/styles.dart';
import '../../../../../generated/l10n.dart';
import '../../domain/entities/booking_addon.dart';
import '../../domain/entities/booking_adjustment.dart';
import '../../domain/entities/booking_drink.dart';

class BillConfirmLineList extends StatelessWidget {
  final List<BookingDrink> drinks;
  final List<BookingAddon> addons;
  final List<BookingAdjustment> adjustments;

  const BillConfirmLineList({
    super.key,
    required this.drinks,
    required this.addons,
    required this.adjustments,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = context.colorScheme;

    if (drinks.isEmpty && addons.isEmpty && adjustments.isEmpty) {
      return Text(
        S().confirmBillNoChanges,
        style: font12w400.copyWith(color: scheme.onSurfaceVariant),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final drink in drinks)
          _buildLine(scheme, '${drink.name ?? ''} × ${drink.quantity}', (drink.price ?? 0) * drink.quantity),
        for (final addon in addons)
          _buildLine(
            scheme,
            '${addon.name ?? ''} × ${addon.quantity}',
            addon.lineTotal ?? (addon.price ?? 0) * addon.quantity,
          ),
        for (final adjustment in adjustments)
          _buildLine(scheme, adjustment.label, adjustment.amount, isAdjustment: true),
      ],
    );
  }

  Widget _buildLine(ColorScheme scheme, String label, int amount, {bool isAdjustment = false}) {
    final isNegative = isAdjustment && amount < 0;
    final sign = isAdjustment ? (isNegative ? '- ' : '+ ') : '';
    final color = isAdjustment
        ? (isNegative ? Colors.redAccent : Colors.green)
        : scheme.onSurface;

    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: font12w400.copyWith(color: scheme.onSurface),
            ),
          ),
          Text(
            '$sign${S().currencyEgp(amount.abs())}',
            textDirection: TextDirection.ltr,
            style: font12w400.copyWith(color: color, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}
