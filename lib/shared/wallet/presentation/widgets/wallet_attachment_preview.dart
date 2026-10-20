import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/extensions/ext_theme.dart';
import '../../../../generated/l10n.dart';

class WalletAttachmentPreview extends StatelessWidget {
  final String filePath;

  const WalletAttachmentPreview({super.key, required this.filePath});

  void _openFullScreen(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) => Dialog.fullscreen(
        child: Stack(
          children: [
            InteractiveViewer(
              minScale: 1,
              maxScale: 5,
              child: Center(child: Image.file(File(filePath))),
            ),
            SafeArea(
              child: Align(
                alignment: AlignmentDirectional.topStart,
                child: IconButton(
                  icon: const Icon(Icons.close_rounded),
                  onPressed: () => Navigator.of(dialogContext).pop(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10.h),
      child: GestureDetector(
        onTap: () => _openFullScreen(context),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(14.r),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Image.file(
                File(filePath),
                height: 170.h,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => SizedBox(
                  height: 170.h,
                  child: Center(child: Text(S().documentLoadFailed)),
                ),
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 6.h),
                color: context.colorScheme.scrim.withValues(alpha: 0.45),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.zoom_in_rounded, size: 18.r, color: Colors.white),
                    SizedBox(width: 6.w),
                    Text(
                      S().walletAttachmentTapToView,
                      style: TextStyle(fontSize: 11.sp, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
