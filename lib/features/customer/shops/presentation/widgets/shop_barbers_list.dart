import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../domain/entities/shop_barber.dart';
import 'shop_barber_row.dart';

class ShopBarbersList extends StatelessWidget {
  final List<ShopBarber> barbers;

  const ShopBarbersList({super.key, required this.barbers});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      decoration: BoxDecoration(
        color: context.colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: context.colorScheme.outline),
      ),
      child: Column(
        children: [
          for (final (index, barber) in barbers.indexed)
            ShopBarberRow(barber: barber, showDivider: index != barbers.length - 1),
        ],
      ),
    );
  }
}
