import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/helpers/alerts.dart';
import '../../../../../core/widgets/app_top_bar.dart';
import '../../../../../core/widgets/primary_cta_button.dart';
import '../../../../../core/widgets/section_title.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../shared/widgets/location_blocked_notice.dart';
import '../../../../../shared/widgets/location_notes.dart';
import '../../../../../shared/widgets/location_picker_field.dart';
import '../../domain/entities/merchant_profile.dart';
import '../manager/merchant_profile_cubit.dart';
import '../manager/merchant_profile_state.dart';

class MerchantLocationScreen extends StatefulWidget {
  final MerchantProfile? profile;
  final bool blocking;

  const MerchantLocationScreen({
    super.key,
    this.profile,
    this.blocking = false,
  });

  @override
  State<MerchantLocationScreen> createState() => _MerchantLocationScreenState();
}

class _MerchantLocationScreenState extends State<MerchantLocationScreen> {
  late final _addressController = TextEditingController(
    text: widget.profile?.address ?? '',
  );
  double? _latitude;
  double? _longitude;

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

  Future<void> _submit() async {
    final cubit = context.read<MerchantProfileCubit>();
    final address = _addressController.text.trim();

    final saved = await cubit.updateLocation(
      latitude: _latitude,
      longitude: _longitude,
      address: address.isEmpty ? null : address,
    );

    if (!mounted) return;

    if (saved) {
      showSuccess(S().locationSaved);
      if (!widget.blocking) context.pop();
      return;
    }

    final message = cubit.state.errorMessage;
    if (message != null) showError(message);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.blocking ? null : AppTopBar(title: S().locationTitle),
      body: ListView(
        padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 24.h),
        children: [
          if (widget.blocking) const LocationBlockedNotice(),
          const LocationNotes(),
          SizedBox(height: 16.h),
          SectionTitle(title: S().addressLabel),
          LocationPickerField(
            addressController: _addressController,
            latitude: _latitude,
            longitude: _longitude,
            onLocationPicked: (lat, lng) => setState(() {
              _latitude = lat;
              _longitude = lng;
            }),
          ),
          SizedBox(height: 20.h),
          BlocBuilder<MerchantProfileCubit, MerchantProfileState>(
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
