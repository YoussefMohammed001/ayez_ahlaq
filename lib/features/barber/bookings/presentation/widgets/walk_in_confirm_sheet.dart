import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../core/widgets/primary_cta_button.dart';
import '../../../../../generated/l10n.dart';
import '../../domain/entities/booking_addon.dart';
import '../../domain/entities/booking_drink.dart';

class WalkInConfirmSheet extends StatelessWidget {
  final String serviceName;
  final int servicePrice;
  final String? styleName;
  final int styleDelta;
  final List<BookingDrink> drinks;
  final List<BookingAddon> addons;
  final bool isLoading;
  final VoidCallback onConfirm;

  const WalkInConfirmSheet({
    super.key,
    required this.serviceName,
    required this.servicePrice,
    this.styleName,
    this.styleDelta = 0,
    required this.drinks,
    required this.addons,
    required this.isLoading,
    required this.onConfirm,
  });

  int get _total =>
      servicePrice +
      styleDelta +
      drinks.fold<int>(0, (sum, d) => sum + (d.price ?? 0) * d.quantity) +
      addons.fold<int>(0, (sum, a) => sum + (a.price ?? 0) * a.quantity);

  @override
  Widget build(BuildContext context) {
    final scheme = context.colorScheme;

    return Container(
      padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 24.h),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            S().walkInConfirmTitle,
            style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w700, color: scheme.onSurface),
          ),
          SizedBox(height: 12.h),
          _row(context, serviceName, 1, servicePrice),
          if (styleName != null) _row(context, styleName!, 1, styleDelta),
          for (final drink in drinks) _row(context, drink.name ?? '', drink.quantity, drink.price ?? 0),
          for (final addon in addons) _row(context, addon.name ?? '', addon.quantity, addon.price ?? 0),
          Divider(height: 24.h, color: scheme.outline),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                S().walkInConfirmTotalLabel,
                style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w700, color: scheme.onSurface),
              ),
              Text(
                S().currencyEgp(_total),
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w800,
                  color: context.semantic.accentSoft,
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: isLoading ? null : () => Navigator.of(context).pop(),
                  child: Text(S().walkInConfirmEdit),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                flex: 2,
                child: PrimaryCtaButton(
                  label: S().walkInConfirmAction,
                  isLoading: isLoading,
                  onPressed: onConfirm,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _row(BuildContext context, String name, int quantity, int price) {
    final scheme = context.colorScheme;

    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        children: [
          Expanded(
            child: Text(
              '$quantity× $name',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 13.sp, color: scheme.onSurface),
            ),
          ),
          Text(
            S().currencyEgp(price * quantity),
            style: TextStyle(fontSize: 13.sp, color: scheme.onSurfaceVariant),
          ),
        ],
      ),
    );
  }
}
