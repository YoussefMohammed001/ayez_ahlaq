import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/helpers/alerts.dart';
import '../../../../../core/widgets/app_text_field.dart';
import '../../../../../core/widgets/app_top_bar.dart';
import '../../../../../core/widgets/primary_cta_button.dart';
import '../../../../../core/widgets/section_title.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../generated/l10n.dart';
import '../../domain/entities/barber_profile.dart';
import '../manager/barber_profile_cubit.dart';
import '../manager/barber_profile_state.dart';

class BarberLocationScreen extends StatefulWidget {
  final BarberProfile? profile;

  const BarberLocationScreen({super.key, this.profile});

  @override
  State<BarberLocationScreen> createState() => _BarberLocationScreenState();
}

class _BarberLocationScreenState extends State<BarberLocationScreen> {
  late final _addressController = TextEditingController(
    text: widget.profile?.address ?? '',
  );
  double? _latitude;
  double? _longitude;
  bool _isLocating = false;

  @override
  void initState() {
    super.initState();
    _latitude = widget.profile?.latitude;
    _longitude = widget.profile?.longitude;
  }

  @override
  void dispose() {
    _addressController.dispose();
    super.dispose();
  }

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
      setState(() {
        _latitude = position.latitude;
        _longitude = position.longitude;
      });
    } catch (e) {
      if (mounted) showError(e is String ? e : S().somethingWentWrong);
    } finally {
      if (mounted) setState(() => _isLocating = false);
    }
  }

  Future<void> _submit() async {
    final cubit = context.read<BarberProfileCubit>();
    final address = _addressController.text.trim();

    final saved = await cubit.updateLocation(
      latitude: _latitude,
      longitude: _longitude,
      address: address.isEmpty ? null : address,
    );

    if (!mounted) return;

    if (saved) {
      showSuccess(S().locationSaved);
      context.pop();
      return;
    }

    final message = cubit.state.errorMessage;
    if (message != null) showError(message);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppTopBar(title: S().locationTitle),
      body: ListView(
        padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 24.h),
        children: [
          Text(
            S().locationNote,
            style: TextStyle(
              fontSize: 12.5.sp,
              height: 1.8,
              color: context.colorScheme.onSurfaceVariant,
            ),
          ),
          SizedBox(height: 16.h),
          PrimaryCtaButton(
            label: S().useCurrentLocation,
            isLoading: _isLocating,
            onPressed: _useCurrentLocation,
          ),
          if (_latitude != null && _longitude != null) ...[
            SizedBox(height: 10.h),
            Text(
              '${_latitude!.toStringAsFixed(5)}, ${_longitude!.toStringAsFixed(5)}',
              style: TextStyle(fontSize: 12.sp, color: context.colorScheme.onSurfaceVariant),
            ),
          ],
          SectionTitle(title: S().addressLabel),
          AppTextField(controller: _addressController, hint: S().addressHint),
          SizedBox(height: 20.h),
          BlocBuilder<BarberProfileCubit, BarberProfileState>(
            builder: (context, state) => PrimaryCtaButton(
              label: S().save,
              isLoading: state.isSubmitting,
              onPressed: _submit,
            ),
          ),
        ],
      ),
    );
  }
}
