import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../domain/entities/shop_barber.dart';

class ShopServicesOverview extends StatelessWidget {
  final List<ShopBarber> barbers;

  const ShopServicesOverview({super.key, required this.barbers});

  List<ShopBarberService> get _uniqueServices {
    final seen = <int>{};
    final result = <ShopBarberService>[];
    for (final barber in barbers) {
      for (final service in barber.services) {
        if (seen.add(service.serviceTypeId)) result.add(service);
      }
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    final scheme = context.colorScheme;
    final services = _uniqueServices;
    if (services.isEmpty) return const SizedBox.shrink();

    return Wrap(
      spacing: 8.w,
      runSpacing: 8.h,
      children: services
          .map(
            (service) => Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: scheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Text(
                '${service.name} · ${service.price}',
                style: TextStyle(
                  fontSize: 11.5.sp,
                  fontWeight: FontWeight.w600,
                  color: scheme.onSurfaceVariant,
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
