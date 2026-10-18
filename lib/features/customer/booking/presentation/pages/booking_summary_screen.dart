import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/helpers/alerts.dart';
import '../../../../../core/helpers/show_confirm_dialog.dart';
import '../../../../../core/routes/route_paths.dart';
import '../../../../../core/widgets/app_text_field.dart';
import '../../../../../core/widgets/app_top_bar.dart';
import '../../../../../core/widgets/primary_cta_button.dart';
import '../../../../../core/widgets/section_title.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../shared/widgets/success_screen_args.dart';
import '../manager/booking_flow_cubit.dart';
import '../manager/booking_flow_state.dart';
import '../widgets/booking_addons_picker_field.dart';
import '../widgets/booking_drinks_picker_field.dart';
import '../widgets/booking_payment_methods_row.dart';
import '../widgets/same_day_booking_warning.dart';
import '../widgets/booking_summary_card.dart';

class BookingSummaryScreen extends StatefulWidget {
  const BookingSummaryScreen({super.key});

  @override
  State<BookingSummaryScreen> createState() => _BookingSummaryScreenState();
}

class _BookingSummaryScreenState extends State<BookingSummaryScreen> {
  final _noteController = TextEditingController();

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  Future<void> _confirmAndSubmit(
    BuildContext context,
    BookingFlowCubit cubit,
  ) async {
    final hasSameDayBooking = await cubit.hasSameDayBooking();
    if (!context.mounted) return;

    final confirmed = await showConfirmDialog(
      context,
      title: S().confirmBooking,
      message: S().confirmBookingMessage,
      confirmLabel: hasSameDayBooking
          ? S().sameDayBookingConfirmLabel
          : S().confirmBooking,
      icon: Icons.event_available_rounded,
      isDestructive: false,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (hasSameDayBooking) ...[
            SameDayBookingWarning(date: cubit.state.date ?? ''),
            SizedBox(height: 10.h),
          ],
          BookingSummaryCard(state: cubit.state),
        ],
      ),
    );

    if (!confirmed) return;

    cubit.setNote(_noteController.text.trim());
    cubit.submit();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppTopBar(title: S().bookingSummaryTitle),
      body: BlocConsumer<BookingFlowCubit, BookingFlowState>(
        listener: (context, state) {
          if (state.status == BookingFlowStatus.success) {
            context.go(
              Routes.successScreen,
              extra: SuccessScreenArgs(
                message: state.successMessage ?? S().bookingCreatedMessage,
                doneRoute: Routes.customerShell,
              ),
            );
          }
          if (state.status == BookingFlowStatus.failure &&
              state.errorMessage != null) {
            showError(state.errorMessage!);
          }
        },
        builder: (context, state) {
          final cubit = context.read<BookingFlowCubit>();

          return Column(
            children: [
              Expanded(
                child: ListView(
                  padding: EdgeInsets.fromLTRB(20.w, 14.h, 20.w, 24.h),
                  children: [
                    BookingSummaryCard(state: state),
                    if (state.shopDetail!.drinks.isNotEmpty) ...[
                      SectionTitle(title: S().drinksTitle),
                      BookingDrinksPickerField(
                        shopDrinks: state.shopDetail!.drinks,
                        selectedDrinks: state.drinks,
                        onQuantityChanged: cubit.setDrinkQuantity,
                      ),
                    ],
                    if (state.shopDetail!.addons.isNotEmpty) ...[
                      SectionTitle(title: S().walkInAddonsLabel),
                      BookingAddonsPickerField(
                        shopAddons: state.shopDetail!.addons,
                        selectedAddons: state.addons,
                        onQuantityChanged: cubit.setAddonQuantity,
                      ),
                    ],
                    SectionTitle(title: S().paymentMethodsSectionTitle),
                    BookingPaymentMethodsRow(
                      methods: state.shopDetail!.paymentMethods,
                      selectedCode: state.paymentMethod,
                      onSelected: cubit.setPaymentMethod,
                    ),
                    SectionTitle(title: S().walkInNoteLabel),
                    AppTextField(
                      controller: _noteController,
                      hint: S().walkInNoteLabel,
                      maxLines: 3,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 20.h),
                child: PrimaryCtaButton(
                  label: S().confirmBooking,
                  isLoading: state.status == BookingFlowStatus.submitting,
                  onPressed: () => _confirmAndSubmit(context, cubit),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
