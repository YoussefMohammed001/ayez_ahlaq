import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../generated/l10n.dart';
import '../../domain/entities/booking_adjustment.dart';

class BookingAdjustmentsSection extends StatelessWidget {
  final List<BookingAdjustment> adjustments;

  const BookingAdjustmentsSection({super.key, required this.adjustments});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            S().billAdjustments,
            style: TextStyle(fontSize: 12.sp, color: context.colorScheme.onSurfaceVariant),
          ),
          SizedBox(height: 4.h),
          for (final adjustment in adjustments) _buildRow(context, adjustment),
        ],
      ),
    );
  }

  Widget _buildRow(BuildContext context, BookingAdjustment adjustment) {
    return Padding(
      padding: EdgeInsets.only(bottom: 2.h),
      child: Row(
        children: [
          Expanded(
            child: Text(
              adjustment.label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 12.5.sp, color: context.colorScheme.onSurface),
            ),
          ),
          Text(
            '${adjustment.isDiscount ? '' : '+'}${S().currencyEgp(adjustment.amount)}',
            textDirection: TextDirection.ltr,
            style: TextStyle(
              fontSize: 12.5.sp,
              fontWeight: FontWeight.w600,
              color: adjustment.isDiscount
                  ? context.semantic.success
                  : context.colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}
