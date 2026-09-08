import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/helpers/alerts.dart';
import '../../../../../core/widgets/primary_cta_button.dart';
import '../../../../../core/widgets/section_title.dart';
import '../../../../../generated/l10n.dart';
import '../../../services/presentation/manager/barber_services_cubit.dart';
import '../../domain/entities/booking_addon.dart';
import '../../domain/entities/booking_drink.dart';
import '../manager/bookings_cubit.dart';
import 'walk_in_confirm_sheet.dart';
import 'walk_in_extras_fields.dart';
import 'walk_in_assignment_fields.dart';
import 'walk_in_customer_fields.dart';
import 'walk_in_sheet_container.dart';

const _walkInPaymentMethod = 'CASH';

class AddWalkInSheet extends StatefulWidget {
  final bool isOwner;
  final int? ownBarberId;

  const AddWalkInSheet({super.key, this.isOwner = false, this.ownBarberId});

  @override
  State<AddWalkInSheet> createState() => _AddWalkInSheetState();
}

class _AddWalkInSheetState extends State<AddWalkInSheet> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _noteController = TextEditingController();
  final _addons = ValueNotifier<List<BookingAddon>>(const []);
  final _drinks = ValueNotifier<List<BookingDrink>>(const []);
  int? _serviceId;
  int? _barberId;
  String? _slotTime;

  @override
  void initState() {
    super.initState();
    _barberId = widget.ownBarberId;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _noteController.dispose();
    _addons.dispose();
    _drinks.dispose();
    super.dispose();
  }

  String? _textOrNull(TextEditingController controller) {
    final text = controller.text.trim();
    return text.isEmpty ? null : text;
  }

  void _reviewAndSubmit() {
    if (!_formKey.currentState!.validate()) return;

    showWalkInConfirmSheet(
      context,
      drinks: _drinks.value,
      addons: _addons.value,
      onConfirm: _confirm,
    );
  }

  Future<void> _confirm(BuildContext sheetContext) async {
    final services = context.read<BarberServicesCubit>().state.services;
    final selected = services.firstWhere((s) => s.id == _serviceId);
    final bookingsCubit = context.read<BookingsCubit>();

    final saved = await bookingsCubit.createWalkIn(
      barberId: _barberId!,
      serviceTypeId: selected.catalogId,
      customerName: _textOrNull(_nameController),
      customerPhone: _textOrNull(_phoneController),
      slotTime: _slotTime,
      paymentMethod: _walkInPaymentMethod,
      note: _textOrNull(_noteController),
      addons: _addons.value,
      drinks: _drinks.value,
    );

    if (!sheetContext.mounted) return;

    if (saved) {
      Navigator.of(sheetContext).pop();
      if (mounted) Navigator.of(context).pop();
      return;
    }

    final message = bookingsCubit.state.errorMessage;
    if (message != null) showError(message);
  }

  @override
  Widget build(BuildContext context) {
    return WalkInSheetContainer(
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionTitle(title: S().addWalkInTitle),
            WalkInAssignmentFields(
              isOwner: widget.isOwner,
              serviceId: _serviceId,
              barberId: _barberId,
              onServiceChanged: (value) => setState(() => _serviceId = value),
              onBarberChanged: (value) => setState(() => _barberId = value),
            ),
            WalkInCustomerFields(
              nameController: _nameController,
              phoneController: _phoneController,
              noteController: _noteController,
            ),
            WalkInExtrasFields(
              slotTime: _slotTime,
              onSlotTimeChanged: (value) => setState(() => _slotTime = value),
              drinks: _drinks,
              addons: _addons,
            ),
            SizedBox(height: 20.h),
            PrimaryCtaButton(
              label: S().addWalkInAction,
              onPressed: _reviewAndSubmit,
            ),
          ],
        ),
      ),
    );
  }
}
