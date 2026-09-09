import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import '../../core/helpers/alerts.dart';
import '../../core/widgets/app_text_field.dart';
import '../../core/widgets/primary_cta_button.dart';
import '../../core/extensions/ext_theme.dart';
import '../../generated/l10n.dart';

class DeliveryLocationField extends StatefulWidget {
  final TextEditingController addressController;
  final double? latitude;
  final double? longitude;
  final void Function(double lat, double lng) onLocationPicked;

  const DeliveryLocationField({
    super.key,
    required this.addressController,
    required this.latitude,
    required this.longitude,
    required this.onLocationPicked,
  });

  @override
  State<DeliveryLocationField> createState() => _DeliveryLocationFieldState();
}

class _DeliveryLocationFieldState extends State<DeliveryLocationField> {
  bool _isLocating = false;

  Future<void> _useCurrentLocation() async {
    setState(() => _isLocating = true);

    try {
      if (!await Geolocator.isLocationServiceEnabled()) {
        throw S().locationServiceDisabled;
      }

      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        throw S().locationPermissionDenied;
      }

      final position = await Geolocator.getCurrentPosition();
      widget.onLocationPicked(position.latitude, position.longitude);
    } catch (e) {
      if (mounted) showError(e is String ? e : S().somethingWentWrong);
    } finally {
      if (mounted) setState(() => _isLocating = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PrimaryCtaButton(
          label: S().useCurrentLocation,
          isLoading: _isLocating,
          onPressed: _useCurrentLocation,
        ),
        if (widget.latitude != null && widget.longitude != null) ...[
          SizedBox(height: 10.h),
          Text(
            '${widget.latitude!.toStringAsFixed(5)}, ${widget.longitude!.toStringAsFixed(5)}',
            style: TextStyle(fontSize: 12.sp, color: context.colorScheme.onSurfaceVariant),
          ),
        ],
        SizedBox(height: 10.h),
        AppTextField(controller: widget.addressController, hint: S().addressHint),
      ],
    );
  }
}
