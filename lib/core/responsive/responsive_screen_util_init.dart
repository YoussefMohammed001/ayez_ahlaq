import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'responsive_scale.dart';

class ResponsiveScreenUtilInit extends StatelessWidget {
  final ScreenUtilInitBuilder builder;

  const ResponsiveScreenUtilInit({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: ResponsiveScale.designSizeFor(MediaQuery.sizeOf(context)),
      minTextAdapt: true,
      splitScreenMode: true,
      useInheritedMediaQuery: true,
      builder: builder,
    );
  }
}
