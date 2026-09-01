import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/network/constants/endpoints.dart';
import '../../../../../core/widgets/authorized_network_image.dart';
import '../../domain/entities/merchant_category.dart';
import '../../../../../core/extensions/ext_theme.dart';

class CategoryThumbnail extends StatelessWidget {
  final MerchantCategory? category;
  final double size;
  final double? radius;

  const CategoryThumbnail({
    super.key,
    required this.category,
    required this.size,
    this.radius,
  });

  @override
  Widget build(BuildContext context) {
    final corner = BorderRadius.circular(radius ?? 12.r);
    final current = category;

    if (current == null || !current.hasImage) {
      return _buildPlaceholder(context, corner);
    }

    return ClipRRect(
      borderRadius: corner,
      child: AuthorizedNetworkImage(
        endPoint: EndPoints.merchantCategoryImage(current.id),
        width: size,
        height: size,
        placeholderBuilder: (context) => _buildPlaceholder(context, corner),
      ),
    );
  }

  Widget _buildPlaceholder(BuildContext context, BorderRadius corner) {
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: context.colorScheme.primaryContainer,
        borderRadius: corner,
      ),
      child: Icon(
        Icons.category_outlined,
        size: size * 0.45,
        color: context.semantic.accentSoft,
      ),
    );
  }
}
