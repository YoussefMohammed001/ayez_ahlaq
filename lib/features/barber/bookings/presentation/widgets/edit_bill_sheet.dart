import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/di/services_locator.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../core/helpers/alerts.dart';
import '../../../../../core/widgets/primary_cta_button.dart';
import '../../../../../core/widgets/section_title.dart';
import '../../../../../core/widgets/sheet_grabber.dart';
import '../../../../../generated/l10n.dart';
import '../../../drinks/presentation/manager/barber_drinks_cubit.dart';
import '../../domain/entities/booking.dart';
import '../../domain/entities/booking_addon.dart';
import '../../domain/entities/booking_adjustment.dart';
import '../../domain/entities/booking_drink.dart';
import '../manager/bookings_cubit.dart';
import '../manager/bookings_state.dart';
import 'bill_adjustments_field.dart';
import 'bill_confirm_dialog.dart';
import 'edit_bill_title.dart';
import 'walk_in_drinks_field.dart';

class EditBillSheet extends StatefulWidget {
  final Booking booking;

  const EditBillSheet({super.key, required this.booking});

  static Future<void> show(BuildContext context, Booking booking) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => MultiBlocProvider(
        providers: [
          BlocProvider.value(value: context.read<BookingsCubit>()),
          BlocProvider.value(value: sl<BarberDrinksCubit>()..loadDrinks()),
        ],
        child: EditBillSheet(booking: booking),
      ),
    );
  }

  @override
  State<EditBillSheet> createState() => _EditBillSheetState();
}

class _EditBillSheetState extends State<EditBillSheet> {
  late final ValueNotifier<List<BookingDrink>> _drinks;
  late List<BookingAddon> _addons;
  late List<BookingAdjustment> _adjustments;

  @override
  void initState() {
    super.initState();
    _drinks = ValueNotifier(
      widget.booking.addons
          .where((a) => a.isDrink)
          .map(
            (a) => BookingDrink(
              drinkId: a.drinkId!,
              quantity: a.quantity,
              name: a.name,
              price: a.price,
            ),
          )
          .toList(),
    );
    _addons = widget.booking.addons.where((a) => !a.isDrink).toList();
    _adjustments = widget.booking.adjustments;
  }

  @override
  void dispose() {
    _drinks.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final adjustments = _adjustments
        .where((a) => a.label.isNotEmpty || a.amount != 0)
        .toList();

    final confirmed = await BillConfirmDialog.showFor(
      context,
      booking: widget.booking,
      drinks: _drinks.value,
      addons: _addons,
      adjustments: adjustments,
    );

    if (!confirmed || !mounted) return;

    final cubit = context.read<BookingsCubit>();
    final saved = await cubit.updateBilling(
      id: widget.booking.id,
      drinks: _drinks.value,
      addons: _addons,
      adjustments: adjustments,
    );

    if (!mounted) return;

    if (saved) {
      showSuccess(S().billSaved);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.viewInsetsOf(context).bottom,
      ),
      child: Container(
        padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 24.h),
        decoration: BoxDecoration(
          color: context.colorScheme.surface,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SheetGrabber(),
              const EditBillTitle(),
              SizedBox(height: 6.h),
              SectionTitle(title: S().drinksTitle),
              WalkInDrinksField(drinks: _drinks),
              SectionTitle(title: S().billAdjustments),
              BillAdjustmentsField(
                adjustments: _adjustments,
                onChanged: (adjustments) => _adjustments = adjustments,
              ),
              SizedBox(height: 20.h),
              BlocBuilder<BookingsCubit, BookingsState>(
                builder: (_, state) => PrimaryCtaButton(
                  label: S().save,
                  isLoading: state.updatingBookingId == widget.booking.id,
                  onPressed: _submit,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
