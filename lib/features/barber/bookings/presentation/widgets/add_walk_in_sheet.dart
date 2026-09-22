import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/helpers/alerts.dart';
import '../../../../../core/widgets/primary_cta_button.dart';
import '../../../../../core/widgets/section_title.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../shared/widgets/busy_error_listener.dart';
import '../../domain/entities/booking_addon.dart';
import '../../domain/entities/booking_drink.dart';
import '../manager/bookings_cubit.dart';
import '../manager/bookings_state.dart';
import '../manager/walk_in_options_cubit.dart';
import 'walk_in_confirm_sheet_launcher.dart';
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

  void _reviewAndSubmit(BookingsState state) {
    if (state.isSubmittingWalkIn) return;
    if (!_formKey.currentState!.validate()) return;

    final options = context.read<WalkInOptionsCubit>().state.options;

    showWalkInConfirmSheet(
      context,
      option: options.where((o) => o.serviceTypeId == _serviceId).firstOrNull,
      barberId: _barberId,
      drinks: _drinks.value,
      addons: _addons.value,
      onConfirm: _confirm,
    );
  }

  Future<void> _confirm(BuildContext sheetContext) async {
    final barberId = _barberId;
    final serviceTypeId = _serviceId;
    if (barberId == null || serviceTypeId == null) {
      showError(S().somethingWentWrong);
      return;
    }
    final bookingsCubit = context.read<BookingsCubit>();
    if (bookingsCubit.state.isSubmittingWalkIn) return;
    final saved = await bookingsCubit.createWalkIn(
      barberId: barberId,
      serviceTypeId: serviceTypeId,
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
    }
  }

  @override
  Widget build(BuildContext context) {
    return BusyErrorListener<BookingsCubit, BookingsState>(
      isBusy: (state) => state.isSubmittingWalkIn,
      errorMessage: (state) => state.errorMessage,
      child: WalkInSheetContainer(child: Form(key: _formKey, child: _buildFields())),
    );
  }

  Widget _buildFields() {
    return Column(
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
        BlocBuilder<BookingsCubit, BookingsState>(
          builder: (context, state) => PrimaryCtaButton(
            label: S().addWalkInAction,
            isLoading: state.isSubmittingWalkIn,
            onPressed: () => _reviewAndSubmit(state),
          ),
        ),
      ],
    );
  }
}
