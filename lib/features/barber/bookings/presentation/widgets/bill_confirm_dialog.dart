import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../core/theme/heading_styles.dart';
import '../../../../../core/theme/styles.dart';
import '../../../../../generated/l10n.dart';
import '../../domain/entities/booking.dart';
import '../../domain/entities/booking_addon.dart';
import '../../domain/entities/booking_adjustment.dart';
import '../../domain/entities/booking_drink.dart';
import 'bill_confirm_line_list.dart';

class BillConfirmDialog extends StatelessWidget {
  final List<BookingDrink> drinks;
  final List<BookingAddon> addons;
  final List<BookingAdjustment> adjustments;
  final int newTotal;

  const BillConfirmDialog({
    super.key,
    required this.drinks,
    required this.addons,
    required this.adjustments,
    required this.newTotal,
  });

  static Future<bool> showFor(
    BuildContext context, {
    required Booking booking,
    required List<BookingDrink> drinks,
    required List<BookingAddon> addons,
    required List<BookingAdjustment> adjustments,
  }) async {
    final drinksTotal = drinks.fold<int>(
      0,
      (sum, drink) => sum + (drink.price ?? 0) * drink.quantity,
    );
    final addonsTotal = addons.fold<int>(
      0,
      (sum, addon) => sum + (addon.lineTotal ?? (addon.price ?? 0) * addon.quantity),
    );
    final adjustmentsTotal = adjustments.fold<int>(0, (sum, a) => sum + a.amount);
    final newTotal =
        booking.basePrice + booking.styleDelta + drinksTotal + addonsTotal + adjustmentsTotal;

    final result = await showDialog<bool>(
      context: context,
      builder: (_) => BillConfirmDialog(
        drinks: drinks,
        addons: addons,
        adjustments: adjustments,
        newTotal: newTotal,
      ),
    );
    return result == true;
  }

  @override
  Widget build(BuildContext context) {
    final scheme = context.colorScheme;

    return Dialog(
      backgroundColor: scheme.surfaceContainer,
      insetPadding: EdgeInsets.symmetric(horizontal: 24.w),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.r),
        side: BorderSide(color: scheme.outline),
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(20.w, 22.h, 20.w, 16.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(S().confirmBillTitle, style: HeadingStyles.h5),
            SizedBox(height: 6.h),
            Text(
              S().confirmBillMessage,
              style: font12w400.copyWith(color: scheme.onSurfaceVariant),
            ),
            SizedBox(height: 16.h),
            BillConfirmLineList(drinks: drinks, addons: addons, adjustments: adjustments),
            Divider(height: 24.h, color: scheme.outline),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(S().confirmBillNewTotal, style: font14w600.copyWith(color: scheme.onSurface)),
                Text(
                  S().currencyEgp(newTotal),
                  style: font13w700.copyWith(color: context.semantic.accentSoft, fontSize: 16.sp),
                ),
              ],
            ),
            SizedBox(height: 20.h),
            Row(
              children: [
                Expanded(child: _buildCancel(context, scheme)),
                SizedBox(width: 10.w),
                Expanded(child: _buildConfirm(context, scheme)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCancel(BuildContext context, ColorScheme scheme) {
    return SizedBox(
      height: 46.h,
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: scheme.surfaceContainerHighest,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
            side: BorderSide(color: scheme.outline),
          ),
        ),
        onPressed: () => Navigator.of(context).pop(false),
        child: Text(
          S().cancel,
          style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w700, color: scheme.onSurfaceVariant),
        ),
      ),
    );
  }

  Widget _buildConfirm(BuildContext context, ColorScheme scheme) {
    return SizedBox(
      height: 46.h,
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: context.colorScheme.primary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
        ),
        onPressed: () => Navigator.of(context).pop(true),
        child: Text(
          S().confirmBillSave,
          style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w700, color: scheme.surfaceContainerLowest),
        ),
      ),
    );
  }
}
