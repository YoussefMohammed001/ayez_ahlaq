import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ayez_ahlaq/core/extensions/ext.dart';
import 'package:ayez_ahlaq/core/theme/styles.dart';
import 'package:ayez_ahlaq/core/widgets/app_svg.dart';
import 'package:ayez_ahlaq/core/widgets/bouncing_widgets.dart';
import 'package:ayez_ahlaq/generated/l10n.dart';

import '../constants/assets_manager.dart';

class DefaultAppBar extends StatefulWidget implements PreferredSizeWidget {
  const DefaultAppBar({
    super.key,
    this.title = "",
    this.enableBack = true,
    this.centerTitle = true,
    this.isHomeScreen = false,
    this.withNotification = false,
    this.withUserImage = false,
    required this.onBackPressed,
    this.elevation,
    this.isProfileScreen = false,
    this.actions,
  });

  final bool isProfileScreen;
  final String title;
  final bool enableBack;
  final double? elevation;
  final bool? centerTitle;
  final bool isHomeScreen;
  final bool withNotification;
  final bool withUserImage;
  final VoidCallback? onBackPressed;
  final List<Widget>? actions;

  @override
  State<DefaultAppBar> createState() => _DefaultAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _DefaultAppBarState extends State<DefaultAppBar> {
  @override
  Widget build(BuildContext context) {
    final isRtl = Directionality.of(context) == TextDirection.rtl;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return AppBar(
      automaticallyImplyLeading: false,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      shadowColor: Colors.transparent,
      backgroundColor: isDark
          ? Colors.grey[900]
          : Theme.of(context).colorScheme.primary,
      centerTitle: widget.centerTitle,
      title: widget.centerTitle == true
          ? Text(
              widget.title,
              style: font20w600.copyWith(
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            )
          : Row(
              children: [
                if (widget.enableBack) ...[
                  Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()
                      ..scale(isRtl ? -1.0 : 1.0, 1.0),
                    child: BounceIt(
                      onPressed: widget.onBackPressed,
                      semanticLabel: S().back,
                      child: AppSVG(
                        assetName: AssetsManager.back,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                  ),
                  if (widget.title.isNotEmpty) ...[
                    16.wSpace,
                    Text(
                      widget.title,
                      style: font24w600.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                  ],
                ],
                if (!widget.enableBack && widget.title.isNotEmpty)
                  Text(
                    widget.title,
                    style: font24w600.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
              ],
            ),
      leading: widget.centerTitle == true && widget.enableBack
          ? Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()..scale(isRtl ? -1.0 : 1.0, 1.0),
              child: BounceIt(
                onPressed: widget.onBackPressed,
                semanticLabel: S().back,
                child: Padding(
                  padding: EdgeInsets.all(12.w),
                  child: AppSVG(
                    assetName: AssetsManager.back,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
              ),
            )
          : null,
      actions: [
        if (widget.actions != null) ...widget.actions!,
        if (widget.withNotification)
          IconButton(
            onPressed: () {},
            tooltip: S().notifications,
            icon: Icon(
              Icons.notifications_outlined,
              color: isDark ? Colors.white : null,
            ),
          ),
        if (widget.withUserImage)
          Padding(
            padding: EdgeInsets.only(right: 16.w),
            child: CircleAvatar(
              radius: 18.r,
              backgroundImage: const NetworkImage(
                'https://via.placeholder.com/36x36/333333/FFFFFF?text=U',
              ),
            ),
          ),
      ],
    );
  }
}
