import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/di/services_locator.dart';
import '../../../../../core/widgets/app_text_field.dart';
import '../../../../../core/widgets/primary_cta_button.dart';
import '../../../../../core/widgets/section_title.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../generated/l10n.dart';
import '../../../profile/presentation/manager/barber_profile_cubit.dart';
import '../../../services/presentation/manager/barber_services_cubit.dart';
import '../../../services/presentation/manager/barber_services_state.dart';
import '../../../storefront/products/presentation/manager/barber_storefront_products_cubit.dart';
import '../../../team/presentation/manager/barber_team_cubit.dart';
import '../../../team/presentation/manager/barber_team_state.dart';
import '../../domain/entities/booking_addon.dart';
import '../manager/bookings_cubit.dart';
import '../manager/bookings_state.dart';
import 'walk_in_addons_field.dart';
import 'walk_in_barber_field.dart';
import 'walk_in_service_field.dart';

class AddWalkInSheet extends StatefulWidget {
  final bool isOwner;

  const AddWalkInSheet({super.key, this.isOwner = false});

  static Future<void> show(BuildContext context) {
    final isOwner = context.read<BarberProfileCubit>().state.profile?.owner ?? false;
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => MultiBlocProvider(
        providers: [
          BlocProvider.value(value: context.read<BookingsCubit>()),
          BlocProvider.value(value: context.read<BarberServicesCubit>()),
          BlocProvider.value(value: context.read<BarberStorefrontProductsCubit>()),
          if (isOwner)
            BlocProvider(create: (_) => sl<BarberTeamCubit>()..loadTeam()),
        ],
        child: AddWalkInSheet(isOwner: isOwner),
      ),
    );
  }

  @override
  State<AddWalkInSheet> createState() => _AddWalkInSheetState();
}

class _AddWalkInSheetState extends State<AddWalkInSheet> {
  static const _cashPaymentMethod = 'CASH';

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _noteController = TextEditingController();
  int? _serviceId;
  int? _barberId;
  List<BookingAddon> _addons = const [];

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_serviceId == null || !_formKey.currentState!.validate()) return;

    final services = context.read<BarberServicesCubit>().state.services;
    final selected = services.firstWhere((s) => s.id == _serviceId);

    final saved = await context.read<BookingsCubit>().createWalkIn(
      barberId: _barberId,
      serviceTypeId: selected.catalogId,
      customerName: _nameController.text.trim(),
      customerPhone: _phoneController.text.trim(),
      paymentMethod: _cashPaymentMethod,
      note: _noteController.text.trim().isEmpty
          ? null
          : _noteController.text.trim(),
      addons: _addons,
    );

    if (saved && mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 24.h),
        decoration: BoxDecoration(
          color: context.colorScheme.surface,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SectionTitle(title: S().addWalkInTitle),
                BlocBuilder<BarberServicesCubit, BarberServicesState>(
                  builder: (_, state) => WalkInServiceField(
                    services: state.services,
                    value: _serviceId,
                    onChanged: (value) => setState(() => _serviceId = value),
                  ),
                ),
                if (widget.isOwner) ...[
                  SectionTitle(title: S().walkInBarberLabel),
                  BlocBuilder<BarberTeamCubit, BarberTeamState>(
                    builder: (_, state) => WalkInBarberField(
                      members: state.members.where((m) => !m.owner).toList(),
                      value: _barberId,
                      onChanged: (value) => setState(() => _barberId = value),
                    ),
                  ),
                ],
                SectionTitle(title: S().customerLabel),
                AppTextField(
                  controller: _nameController,
                  hint: S().customerLabel,
                  validator: (v) =>
                      (v ?? '').trim().isEmpty ? S().customerLabel : null,
                ),
                SectionTitle(title: S().customerPhoneLabel),
                AppTextField(
                  controller: _phoneController,
                  hint: S().customerPhoneLabel,
                  isNumber: true,
                  validator: (v) =>
                      (v ?? '').trim().isEmpty ? S().customerPhoneLabel : null,
                ),
                SectionTitle(title: S().walkInNoteLabel),
                AppTextField(
                  controller: _noteController,
                  hint: S().walkInNoteHint,
                  maxLines: 2,
                ),
                SectionTitle(title: S().walkInAddonsLabel),
                WalkInAddonsField(
                  addons: _addons,
                  onChanged: (addons) => setState(() => _addons = addons),
                ),
                SizedBox(height: 20.h),
                BlocBuilder<BookingsCubit, BookingsState>(
                  builder: (_, state) => PrimaryCtaButton(
                    label: S().addWalkInAction,
                    isLoading: state.isSubmittingWalkIn,
                    onPressed: _submit,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
