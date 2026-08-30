import 'package:flutter/material.dart';

import '../constants/assets_manager.dart';
import '../extensions/ext.dart';

class AppAsset extends StatelessWidget {
  const AppAsset({
    super.key,
    required this.assetName,
    this.width,
    this.height,
    this.color,
    this.fit,
    this.borderRadius,
    this.fileExtension,
  });

  final String assetName;
  final double? width;
  final double? height;
  final Color? color;
  final BoxFit? fit;
  final BorderRadius? borderRadius;
  final String? fileExtension;

  @override
  Widget build(BuildContext context) {
    String assetPath = assetName;

    if (!assetPath.contains('assets')) {
      if (fileExtension != null) {
        assetPath = "assets/images/$assetPath.$fileExtension";
      } else {
        if (!assetPath.contains('.')) {
          assetPath = _getAssetPathWithExtension(assetPath);
        } else {
          assetPath = "assets/images/$assetPath";
        }
      }
    }

    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.zero,
      child: Image.asset(
        assetPath,
        height: height,
        width: width,
        color: color,
        fit: fit,
        errorBuilder: (context, error, stackTrace) {
          return AppAsset(
            borderRadius: 16.bRadius,
            assetName: AssetsManager.errorImage,
            fit: BoxFit.cover,
          );
        },
      ),
    );
  }

  String _getAssetPathWithExtension(String assetName) {
    String pngPath = "assets/images/$assetName.png";
    return pngPath;
  }
}
