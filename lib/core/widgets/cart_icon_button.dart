import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../extensions/ext_theme.dart';

class CartIconButton extends StatelessWidget {
  final int itemCount;
  final VoidCallback onPressed;

  const CartIconButton({
    super.key,
    required this.itemCount,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = context.colorScheme;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        IconButton(
          onPressed: onPressed,
          icon: Icon(Icons.shopping_bag_outlined, color: scheme.onSurface),
        ),
        if (itemCount > 0)
          Positioned(
            top: 6.h,
            right: 6.w,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
              constraints: BoxConstraints(minWidth: 16.r),
              decoration: BoxDecoration(
                color: scheme.primary,
                borderRadius: BorderRadius.circular(100.r),
              ),
              child: Text(
                itemCount > 99 ? '99+' : '$itemCount',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 9.5.sp,
                  fontWeight: FontWeight.w800,
                  color: scheme.surfaceContainerLowest,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
