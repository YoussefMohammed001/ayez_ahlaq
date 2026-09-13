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

    return Padding(
      padding: EdgeInsets.only(bottom: 10.h, top: service.popular ? 10.h : 0),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          AppCard(
            onTap: onEdit,
            borderColor: service.popular ? context.semantic.accentStrong : null,
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
                SizedBox(width: 4.w),
                PopupMenuButton<VoidCallback>(
                  icon: Icon(Icons.more_vert_rounded, color: scheme.onSurfaceVariant),
                  onSelected: (action) => action(),
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: onEdit,
                      child: Text(S().edit),
                    ),
                    PopupMenuItem(
                      value: onDelete,
                      child: Text(S().delete, style: TextStyle(color: context.semantic.warning)),
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (service.popular)
            Positioned(
              top: -10.h,
              right: 14.w,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: context.semantic.accentStrong,
                  borderRadius: BorderRadius.circular(100.r),
                ),
                child: Text(
                  S().servicePopularLabel,
                  style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w700,
                    color: scheme.surfaceContainerLowest,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
