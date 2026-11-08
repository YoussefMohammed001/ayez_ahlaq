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
  final VoidCallback onAllAreas;
  final TextEditingController? searchController;
  final ValueChanged<String>? onSearchChanged;

  const ShopsFilterHeader({
    super.key,
    required this.mode,
    required this.areaLabel,
    required this.onMyLocation,
    required this.onPickPlace,
    required this.onAllAreas,
    this.searchController,
    this.onSearchChanged,
  });

  String get _hint => switch (mode) {
    ShopsBrowseMode.device => S().shopsHintDevice,
    ShopsBrowseMode.custom => S().shopsHintCustom(areaLabel ?? ''),
    ShopsBrowseMode.all => S().shopsHintAll,
  };

  @override
  Widget build(BuildContext context) {
    final scheme = context.colorScheme;
    final hasLabel = areaLabel != null && areaLabel!.isNotEmpty;

    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 6.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ShopsModePill(
                  icon: Icons.my_location_rounded,
                  label: S().shopsAreaMyLocation,
                  selected: mode == ShopsBrowseMode.device,
                  onTap: onMyLocation,
                ),
                SizedBox(width: 8.w),
                ShopsModePill(
                  icon: Icons.place_rounded,
                  label: hasLabel ? areaLabel! : S().shopsAreaOther,
                  selected: mode == ShopsBrowseMode.custom,
                  opensPicker: true,
                  onTap: onPickPlace,
                ),
                SizedBox(width: 8.w),
                ShopsModePill(
                  icon: Icons.public_rounded,
                  label: S().shopsAllAreas,
                  selected: mode == ShopsBrowseMode.all,
                  onTap: onAllAreas,
                ),
              ],
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            _hint,
            style: TextStyle(fontSize: 12.sp, color: scheme.onSurfaceVariant),
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
