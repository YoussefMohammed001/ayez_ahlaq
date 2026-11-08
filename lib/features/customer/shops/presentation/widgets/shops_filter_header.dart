import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../core/widgets/app_search_field.dart';
import '../../../../../generated/l10n.dart';
import '../../domain/entities/shops_browse_mode.dart';
import 'shops_mode_pill.dart';

class ShopsFilterHeader extends StatelessWidget {
  final ShopsBrowseMode mode;
  final String? areaLabel;
  final VoidCallback onMyLocation;
  final VoidCallback onPickPlace;
  final TextEditingController? searchController;
  final ValueChanged<String>? onSearchChanged;
  final EdgeInsetsGeometry? padding;

  const ShopsFilterHeader({
    super.key,
    required this.mode,
    required this.areaLabel,
    required this.onMyLocation,
    required this.onPickPlace,
    this.searchController,
    this.onSearchChanged,
    this.padding,
  });

  String get _hint => switch (mode) {
    ShopsBrowseMode.device => S().shopsHintDevice,
    ShopsBrowseMode.custom => S().shopsHintCustom(areaLabel ?? ''),
  };

  @override
  Widget build(BuildContext context) {
    final hasLabel = areaLabel != null && areaLabel!.isNotEmpty;

    return Padding(
      padding: padding ?? EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: ShopsModePill(
                  icon: Icons.my_location_rounded,
                  label: S().shopsAreaMyLocation,
                  selected: mode == ShopsBrowseMode.device,
                  onTap: onMyLocation,
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: ShopsModePill(
                  icon: Icons.place_rounded,
                  label: hasLabel ? areaLabel! : S().shopsAreaOther,
                  selected: mode == ShopsBrowseMode.custom,
                  opensPicker: true,
                  onTap: onPickPlace,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            _hint,
            style: TextStyle(
              fontSize: 12.sp,
              color: context.colorScheme.onSurfaceVariant,
            ),
          ),
          if (searchController != null) ...[
            SizedBox(height: 10.h),
            AppSearchField(
              controller: searchController!,
              hintText: S().shopsSearchHint,
              onChanged: onSearchChanged,
              debounce: const Duration(milliseconds: 150),
            ),
          ],
        ],
      ),
    );
  }
}
