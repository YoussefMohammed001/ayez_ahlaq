import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../core/extensions/ext_theme.dart';

class DocumentImageView extends StatelessWidget {
  final Uint8List bytes;

  const DocumentImageView({super.key, required this.bytes});

  @override
  Widget build(BuildContext context) {
    return InteractiveViewer(
      minScale: 1,
      maxScale: 5,
      child: Center(
        child: Image.memory(
          bytes,
          fit: BoxFit.contain,
          width: double.infinity,
          errorBuilder: (context, _, __) => _buildError(context),
        ),
      ),
    );
  }

  Widget _buildError(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Text(
          S().documentLoadFailed,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12.5.sp,
            color: context.colorScheme.onSurfaceVariant,
          ),
        ),
      ),
    );
  }
}
