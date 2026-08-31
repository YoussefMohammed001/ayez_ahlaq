import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/extensions/ext_theme.dart';
import '../../../../core/theme/heading_styles.dart';
import '../../../../core/theme/styles.dart';

class SplashBody extends StatelessWidget {
  final Animation<double> intro;
  final String title;
  final String tagline;

  const SplashBody({
    super.key,
    required this.intro,
    required this.title,
    required this.tagline,
  });

  @override
  Widget build(BuildContext context) {
    final semantic = context.semantic;

    return Center(
      child: FadeTransition(
        opacity: intro,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 104.r,
              height: 104.r,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: semantic.accentStrong,
              ),
              child: Icon(
                Icons.content_cut_rounded,
                size: 48.r,
                color: semantic.onAccent,
              ),
            ),
            SizedBox(height: 24.h),
            Text(
              title,
              textAlign: TextAlign.center,
              style: HeadingStyles.h1.copyWith(
                color: context.colorScheme.onSurface,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              tagline,
              textAlign: TextAlign.center,
              style: font14w400.copyWith(color: semantic.accentSoft),
            ),
            SizedBox(height: 40.h),
            SizedBox(
              width: 22.r,
              height: 22.r,
              child: CircularProgressIndicator(
                strokeWidth: 2.2,
                valueColor: AlwaysStoppedAnimation(semantic.accentStrong),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
