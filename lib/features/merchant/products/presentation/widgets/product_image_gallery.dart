import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/network/constants/endpoints.dart';
import '../../../../../core/widgets/authorized_network_image.dart';
import '../../domain/entities/merchant_product.dart';
import 'product_thumbnail.dart';

class ProductImageGallery extends StatefulWidget {
  final MerchantProduct product;

  const ProductImageGallery({super.key, required this.product});

  @override
  State<ProductImageGallery> createState() => _ProductImageGalleryState();
}

class _ProductImageGalleryState extends State<ProductImageGallery> {
  final _controller = PageController();
  int _index = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ids = widget.product.imageIds;

    if (ids.isEmpty) {
      return ProductThumbnail(
        product: widget.product,
        size: 220.h,
        radius: 18.r,
      );
    }

    return Column(
      children: [
        SizedBox(
          height: 220.h,
          child: PageView.builder(
            controller: _controller,
            itemCount: ids.length,
            onPageChanged: (value) => setState(() => _index = value),
            itemBuilder: (_, i) => _buildPage(ids[i]),
          ),
        ),
        if (ids.length > 1) _buildDots(context, ids.length),
      ],
    );
  }

  Widget _buildPage(int imageId) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(18.r),
      child: AuthorizedNetworkImage(
        endPoint: EndPoints.merchantProductImageById(
          widget.product.id,
          imageId,
        ),
        width: double.infinity,
        height: 220.h,
        placeholderBuilder: (_) =>
            ProductThumbnail(product: widget.product, size: 220.h, radius: 18.r),
      ),
    );
  }

  Widget _buildDots(BuildContext context, int count) {
    return Padding(
      padding: EdgeInsets.only(top: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (var i = 0; i < count; i++)
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: EdgeInsets.symmetric(horizontal: 3.w),
              width: i == _index ? 18.w : 6.w,
              height: 6.h,
              decoration: BoxDecoration(
                color: i == _index
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.outline,
                borderRadius: BorderRadius.circular(100.r),
              ),
            ),
        ],
      ),
    );
  }
}
