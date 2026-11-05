import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/extensions/ext_theme.dart';
import '../../../../generated/l10n.dart';
import '../../domain/entities/place_info.dart';

class MapPickerSelectedCard extends StatelessWidget {
  final PlaceInfo place;
  final bool isResolving;
  final bool isLocating;
  final VoidCallback onLocateMe;

  const MapPickerSelectedCard({
    super.key,
    required this.place,
    required this.isResolving,
    required this.isLocating,
    required this.onLocateMe,
  });

  String get _title {
    if (isResolving) return S().searchingAddress;
    return place.name.isNotEmpty ? place.name : S().unnamedLocation;
  }

  String get _subtitle {
    if (isResolving) return ' ';
    final address = place.fullAddress;
    if (address.isEmpty) return place.city.isEmpty ? ' ' : place.city;
    final city = place.city;
    return city.isEmpty || address.contains(city) ? address : '$address، $city';
  }

  @override
  Widget build(BuildContext context) {
    final scheme = context.colorScheme;
    final accent = context.semantic.accentStrong;

    return Container(
      constraints: BoxConstraints(minHeight: 92.h),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(color: accent, width: 1.5),
      ),
      child: Row(
        children: [
          InkWell(
            onTap: isLocating ? null : onLocateMe,
            customBorder: const CircleBorder(),
            child: Container(
              width: 46.r,
              height: 46.r,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: accent.withValues(alpha: 0.12),
              ),
              child: isLocating
                  ? Padding(
                      padding: EdgeInsets.all(14.r),
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: accent,
                      ),
                    )
                  : Icon(Icons.near_me_rounded, size: 22.r, color: accent),
            ),
          ),
          SizedBox(width: 14.w),
          Expanded(
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 150),
              opacity: isResolving ? 0.5 : 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    S().selectedLocationLabel,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: accent,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    _title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      color: scheme.onSurface,
                    ),
                  ),
                  Text(
                    _subtitle,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
