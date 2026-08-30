import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/app_card.dart';
import '../../domain/entities/merchant_phone.dart';
import '../../../../../core/extensions/ext_theme.dart';

class PhoneRow extends StatelessWidget {
  final MerchantPhone phone;
  final VoidCallback onRemove;

  const PhoneRow({super.key, required this.phone, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: EdgeInsets.all(12.w),
      margin: EdgeInsets.only(bottom: 10.h),
      child: Row(
        children: [
          Container(
            width: 40.r,
            height: 40.r,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: context.colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(
              Icons.call_outlined,
              size: 18.r,
              color: context.semantic.accentSoft,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  phone.phoneNumber,
                  textDirection: TextDirection.ltr,
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: context.colorScheme.onSurface,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                if (phone.label != null && phone.label!.isNotEmpty) ...[
                  SizedBox(height: 3.h),
                  Text(
                    phone.label!,
                    style: TextStyle(
                      fontSize: 11.sp,
                      color: context.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ],
            ),
          ),
          GestureDetector(
            onTap: onRemove,
            child: Icon(
              Icons.delete_outline,
              size: 18.r,
              color: context.semantic.warning,
            ),
          ),
        ],
      ),
    );
  }
}
