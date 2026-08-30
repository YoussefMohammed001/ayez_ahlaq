import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ayez_ahlaq/core/constants/assets_manager.dart';
import 'package:ayez_ahlaq/core/extensions/ext.dart';
import 'package:ayez_ahlaq/core/widgets/app_asset.dart';
import '../../core/extensions/ext_theme.dart';

class AppImage extends StatefulWidget {
  const AppImage({
    super.key,
    required this.imageUrl,
    this.borderRadius,
    this.width,
    this.height,
    this.fit,
    this.onImageLoaded,
    this.errorWidget,
    this.showprogressIndicator = true,
  });

  final String imageUrl;
  final double? width;
  final double? height;
  final BorderRadiusGeometry? borderRadius;
  final BoxFit? fit;
  final VoidCallback? onImageLoaded;
  final bool showprogressIndicator;
  final Widget? errorWidget;

  @override
  State<AppImage> createState() => _AppImageState();
}

class _AppImageState extends State<AppImage> {
  bool _isImageLoaded = false;

  void _callOnImageLoadedOnce() {
    if (!_isImageLoaded) {
      _isImageLoaded = true;
      widget.onImageLoaded?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: widget.borderRadius ?? BorderRadius.zero,
      child: CachedNetworkImage(
        fit: widget.fit ?? BoxFit.fill,
        width: widget.width,
        height: widget.height,
        imageUrl: widget.imageUrl,
        imageBuilder: (context, imageProvider) {
          _callOnImageLoadedOnce();
          return Image(image: imageProvider, fit: widget.fit ?? BoxFit.fill);
        },
        progressIndicatorBuilder: (context, url, downloadProgress) {
          return widget.showprogressIndicator
              ? SpinKitFadingCircle(
                  color: context.colorScheme.primary,
                  size: 30.h,
                )
              : const SizedBox();
        },
        errorWidget: (context, url, error) {
          return widget.errorWidget ??
              AppAsset(
                borderRadius: 16.bRadius,
                assetName: AssetsManager.errorImage,
                fit: BoxFit.cover,
              );
        },
      ),
    );
  }
}
