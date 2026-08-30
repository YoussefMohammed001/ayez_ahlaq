import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/constants/strings.dart';
import '../../../../../core/network/constants/endpoints.dart';
import '../../../../../core/extensions/ext_theme.dart';

class ExistingImagesRow extends StatelessWidget {
  final int productId;
  final List<int> imageIds;
  final ValueChanged<int> onDelete;

  const ExistingImagesRow({
    super.key,
    required this.productId,
    required this.imageIds,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    if (imageIds.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Wrap(
        spacing: 10.w,
        runSpacing: 10.h,
        children: [for (final id in imageIds) _buildThumb(context, id)],
      ),
    );
  }

  Widget _buildThumb(BuildContext context, int imageId) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12.r),
          child: CachedNetworkImage(
            imageUrl:
                '${AppStrings.baseUrl}${EndPoints.merchantProductImageById(productId, imageId)}',
            width: 78.r,
            height: 78.r,
            fit: BoxFit.cover,
            errorWidget: (_, __, ___) => Container(
              width: 78.r,
              height: 78.r,
              color: context.colorScheme.surfaceContainer,
            ),
          ),
        ),
        PositionedDirectional(
          top: 2.r,
          start: 2.r,
          child: GestureDetector(
            onTap: () => onDelete(imageId),
            child: Container(
              padding: EdgeInsets.all(3.r),
              decoration: BoxDecoration(
                color: context.colorScheme.surfaceContainerLowest,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.close,
                size: 13.r,
                color: context.semantic.warning,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
