import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/app_card.dart';
import '../../../../../core/widgets/toggle_switch.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../generated/l10n.dart';
import '../../domain/entities/barber_service.dart';

class BarberServiceRow extends StatelessWidget {
  final BarberService service;
  final ValueChanged<bool> onToggleActive;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const BarberServiceRow({
    super.key,
    required this.service,
    required this.onToggleActive,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = context.colorScheme;

    return AppCard(
      onTap: onEdit,
      margin: EdgeInsets.only(bottom: 10.h),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  service.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w700,
                    color: scheme.onSurface,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  S().serviceMetaLine(service.price, service.durationMinutes),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 10.5.sp, color: scheme.onSurfaceVariant),
                ),
              ],
            ),
          ),
          ToggleSwitch(value: service.active, onTap: () => onToggleActive(!service.active)),
          SizedBox(width: 8.w),
          GestureDetector(
            onTap: onDelete,
            child: Padding(
              padding: EdgeInsets.all(4.r),
              child: Icon(Icons.delete_outline, size: 20.r, color: context.semantic.warning),
            ),
          ),
        ],
      ),
    );
  }
}
