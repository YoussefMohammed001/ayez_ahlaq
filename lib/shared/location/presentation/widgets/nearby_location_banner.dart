import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/extensions/ext_theme.dart';
import '../../../../generated/l10n.dart';
import '../manager/location_status_cubit.dart';
import 'location_status_scope.dart';

class NearbyLocationBanner extends StatelessWidget {
  final VoidCallback onEnabled;
  final bool locationResolved;

  const NearbyLocationBanner({
    super.key,
    required this.onEnabled,
    this.locationResolved = true,
  });

  @override
  Widget build(BuildContext context) {
    return LocationStatusScope(
      onBecameAvailable: onEnabled,
      builder: (context, status) {
        if (!status.isLoaded) return const SizedBox.shrink();

        final isOff = !status.availability.isAvailable;
        if (!isOff && locationResolved) return const SizedBox.shrink();

        final scheme = context.colorScheme;
        final warning = context.semantic.warning;

        return Container(
          margin: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 8.h),
          padding: EdgeInsets.all(14.r),
          decoration: BoxDecoration(
            color: warning.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(14.r),
            border: Border.all(color: warning.withValues(alpha: 0.4)),
          ),
          child: Row(
            children: [
              Icon(Icons.location_off_outlined, size: 24.r, color: warning),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isOff
                          ? S().nearbyLocationOffTitle
                          : S().locationUnresolvedTitle,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                        color: scheme.onSurface,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      isOff
                          ? S().nearbyLocationOffMessage
                          : S().locationUnresolvedMessage,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              TextButton(
                onPressed: isOff
                    ? context.read<LocationStatusCubit>().enable
                    : onEnabled,
                child: Text(isOff ? S().enableLocationAction : S().retry),
              ),
            ],
          ),
        );
      },
    );
  }
}
