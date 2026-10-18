import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/extensions/text_controller_ext.dart';
import '../../../../../core/helpers/alerts.dart';
import '../../../../../core/widgets/section_title.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../shared/widgets/busy_error_listener.dart';
import '../../domain/entities/booking_addon.dart';
import '../../domain/entities/booking_drink.dart';
import '../../../services/presentation/manager/shop_haircut_styles_cubit.dart';
import '../manager/bookings_cubit.dart';
import '../manager/bookings_state.dart';
import '../manager/walk_in_options_cubit.dart';
import 'walk_in_confirm_sheet_launcher.dart';
import 'walk_in_extras_fields.dart';
import 'walk_in_assignment_fields.dart';
import 'walk_in_customer_fields.dart';
import 'walk_in_sheet_container.dart';
import 'walk_in_submit_button.dart';

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
  int? _styleId;
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

  void _reviewAndSubmit(BookingsState state) {
    if (state.isSubmittingWalkIn) return;
    if (!_formKey.currentState!.validate()) return;

    final options = context.read<WalkInOptionsCubit>().state.options;

    showWalkInConfirmSheet(
      context,
      option: options.where((o) => o.serviceTypeId == _serviceId).firstOrNull,
      barberId: _barberId,
      style: context.read<ShopHaircutStylesCubit>().state.styleById(_styleId),
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
      haircutStyleId: _styleId,
      customerName: _nameController.textOrNull,
      customerPhone: _phoneController.textOrNull,
      slotTime: _slotTime,
      paymentMethod: _walkInPaymentMethod,
      note: _noteController.textOrNull,
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
          styleId: _styleId,
          onStyleChanged: (value) => setState(() => _styleId = value),
          onServiceChanged: (value) => setState(() {
            _serviceId = value;
            _styleId = null;
          }),
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
        WalkInSubmitButton(onSubmit: _reviewAndSubmit),
      ],
    );
  }
}
