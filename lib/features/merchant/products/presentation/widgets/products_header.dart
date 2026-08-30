import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/routes/route_paths.dart';
import '../../../../../core/theme/heading_styles.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../core/extensions/ext_theme.dart';

class ProductsHeader extends StatelessWidget {
  const ProductsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20.w, 14.h, 20.w, 4.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(S().tabProducts, style: HeadingStyles.h2),
          InkWell(
            onTap: () => context.push(Routes.merchantProductFormScreen),
            child: Container(
              width: 36.r,
              height: 36.r,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: context.colorScheme.primary,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                Icons.add,
                color: context.colorScheme.surfaceContainerLowest,
                size: 20.r,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
