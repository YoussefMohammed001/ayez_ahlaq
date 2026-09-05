import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/helpers/alerts.dart';
import '../../../../../core/routes/route_paths.dart';
import '../../../../../core/widgets/app_card.dart';
import '../../../../../core/widgets/app_text_field.dart';
import '../../../../../core/widgets/app_top_bar.dart';
import '../../../../../core/widgets/primary_cta_button.dart';
import '../../../../../core/widgets/section_title.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../shared/widgets/success_screen_args.dart';
import '../manager/booking_flow_cubit.dart';
import '../manager/booking_flow_state.dart';
import '../widgets/summary_row.dart';

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
                message: S().bookingCreatedMessage,
                doneRoute: Routes.customerBookingsScreen,
              ),
            );
          }
          if (state.status == BookingFlowStatus.failure && state.errorMessage != null) {
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
                    AppCard(
                      child: Column(
                        children: [
                          SummaryRow(label: S().serviceLabel, value: state.serviceName ?? ''),
                          if (state.styleName != null)
                            SummaryRow(label: S().styleLabel, value: state.styleName!),
                          SummaryRow(
                            label: S().barberLabel,
                            value: state.barberName ?? S().autoSelectBarber,
                          ),
                          SummaryRow(
                            label: S().bookingDateLabel,
                            value: '${state.date ?? ''} · ${state.slotTime ?? ''}',
                          ),
                          SummaryRow(
                            label: S().orderTotal,
                            value: S().currencyEgp(state.totalPrice),
                            emphasize: true,
                          ),
                        ],
                      ),
                    ),
                    SectionTitle(title: S().paymentMethodsSectionTitle),
                    Wrap(
                      spacing: 8.w,
                      runSpacing: 8.h,
                      children: state.shopDetail!.paymentMethods
                          .map(
                            (method) => ChoiceChip(
                              label: Text(method.name),
                              selected: state.paymentMethod == method.name,
                              onSelected: (_) => cubit.setPaymentMethod(method.name),
                            ),
                          )
                          .toList(),
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
                  onPressed: () {
                    cubit.setNote(_noteController.text.trim());
                    cubit.submit();
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
