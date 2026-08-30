import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ayez_ahlaq/core/widgets/app_image.dart';
import 'package:ayez_ahlaq/core/widgets/default_app_bar.dart';

class FullScreenImageArgs {
  final String imageUrl;

  FullScreenImageArgs(this.imageUrl);
}

class FullScreenImage extends StatelessWidget {
  final FullScreenImageArgs fullScreenImageArgs;

  const FullScreenImage({super.key, required this.fullScreenImageArgs});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(
        onBackPressed: () {
          context.pop();
        },
      ),
      body: Center(
        child: InteractiveViewer(
          minScale: 0.5,
          maxScale: 4.0,
          child: AppImage(imageUrl: fullScreenImageArgs.imageUrl),
        ),
      ),
    );
  }
}
