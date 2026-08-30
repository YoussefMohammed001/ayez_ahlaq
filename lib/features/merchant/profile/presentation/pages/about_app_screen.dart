import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../../../../../core/theme/heading_styles.dart';
import '../../../../../core/widgets/app_top_bar.dart';
import '../../../../../core/widgets/info_row.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../core/extensions/ext_theme.dart';

class AboutAppScreen extends StatelessWidget {
  const AboutAppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppTopBar(title: S().aboutApp),
      body: ListView(
        padding: EdgeInsets.fromLTRB(20.w, 30.h, 20.w, 24.h),
        children: [
          Icon(
            Icons.content_cut_rounded,
            size: 56.r,
            color: context.colorScheme.primary,
          ),
          SizedBox(height: 16.h),
          Center(child: Text(S().appName, style: HeadingStyles.h2)),
          SizedBox(height: 12.h),
          Text(
            S().aboutAppBody,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12.5.sp,
              color: context.colorScheme.onSurfaceVariant,
              height: 1.9,
            ),
          ),
          SizedBox(height: 24.h),
          FutureBuilder<PackageInfo>(
            future: PackageInfo.fromPlatform(),
            builder: (context, snapshot) => InfoRow(
              icon: Icons.info_outline_rounded,
              label: S().version,
              value: snapshot.data?.version ?? '',
            ),
          ),
        ],
      ),
    );
  }
}
