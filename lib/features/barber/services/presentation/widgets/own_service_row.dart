import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/app_card.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../domain/entities/own_service.dart';

class OwnServiceRow extends StatelessWidget {
  final OwnService service;
  final VoidCallback onDelete;

  const OwnServiceRow({
    super.key,
    required this.service,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = context.colorScheme;

    return AppCard(
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
                if (service.description.isNotEmpty) ...[
                  SizedBox(height: 4.h),
                  Text(
                    service.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 10.5.sp, color: scheme.onSurfaceVariant),
                  ),
                ],
              ],
            ),
          ),
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
