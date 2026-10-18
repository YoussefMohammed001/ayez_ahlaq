import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/extensions/ext_theme.dart';
import '../../core/widgets/app_card.dart';
import '../../core/widgets/app_text_field.dart';
import '../../generated/l10n.dart';
import '../location/domain/entities/picked_location.dart';
import '../location/presentation/widgets/map_location_picker_sheet.dart';

class LocationPickerField extends StatelessWidget {
  final TextEditingController addressController;
  final double? latitude;
  final double? longitude;
  final void Function(double lat, double lng) onLocationPicked;
  final String? Function(String?)? addressValidator;

  const LocationPickerField({
    super.key,
    required this.addressController,
    required this.latitude,
    required this.longitude,
    required this.onLocationPicked,
    this.addressValidator,
  });

  bool get _hasLocation => latitude != null && longitude != null;

  Future<void> _pickOnMap(BuildContext context) async {
    final initial = _hasLocation
        ? PickedLocation(
            latitude: latitude!,
            longitude: longitude!,
            address: addressController.text.trim(),
          )
        : null;

    final picked = await MapLocationPickerSheet.show(context, initial: initial);
    if (picked == null) return;

    final addressText = picked.address.isNotEmpty
        ? picked.address
        : picked.name;
    if (addressText.isNotEmpty) addressController.text = addressText;
    onLocationPicked(picked.latitude, picked.longitude);
  }

  @override
  Widget build(BuildContext context) {
    final scheme = context.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppCard(
          onTap: () => _pickOnMap(context),
          borderColor: _hasLocation
              ? context.semantic.accentStrong
              : scheme.outline,
          child: Row(
            children: [
              Icon(
                Icons.map_outlined,
                size: 26.r,
                color: context.semantic.accentStrong,
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _hasLocation
                          ? S().changeLocationOnMap
                          : S().pickLocationOnMap,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                        color: scheme.onSurface,
                      ),
                    ),
                    if (_hasLocation)
                      ValueListenableBuilder<TextEditingValue>(
                        valueListenable: addressController,
                        builder: (_, value, __) => value.text.trim().isEmpty
                            ? const SizedBox.shrink()
                            : Padding(
                                padding: EdgeInsets.only(top: 4.h),
                                child: Text(
                                  value.text.trim(),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 11.5.sp,
                                    color: scheme.onSurfaceVariant,
                                  ),
                                ),
                              ),
                      ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right,
                size: 20.r,
                color: scheme.onSurfaceVariant,
              ),
            ],
          ),
        ),
        SizedBox(height: 10.h),
        AppTextField(
          controller: addressController,
          hint: S().addressHint,
          validator: addressValidator,
        ),
      ],
    );
  }
}
