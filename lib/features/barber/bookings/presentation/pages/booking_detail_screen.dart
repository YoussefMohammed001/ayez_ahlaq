import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/app_top_bar.dart';
import '../../../../../core/widgets/avatar_circle.dart';
import '../../../../../core/widgets/section_title.dart';
import '../../../../../core/widgets/status_badge.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../shared/widgets/busy_error_listener.dart';
import '../../domain/entities/booking.dart';
import '../manager/bookings_cubit.dart';
import '../manager/bookings_state.dart';
import '../widgets/booking_actions.dart';
import '../widgets/booking_info_card.dart';
import '../widgets/booking_status_label.dart';
import '../widgets/booking_status_tone.dart';
import '../widgets/edit_bill_sheet.dart';

class BookingDetailScreen extends StatefulWidget {
  final Booking booking;

  const BookingDetailScreen({super.key, required this.booking});

  @override
  State<BookingDetailScreen> createState() => _BookingDetailScreenState();
}

class _BookingDetailScreenState extends State<BookingDetailScreen> {
  @override
  void initState() {
    super.initState();
    context.read<BookingsCubit>().refreshBooking(widget.booking.id);
  }

  Future<void> _refresh() =>
      context.read<BookingsCubit>().refreshBooking(widget.booking.id);

  Booking _resolve(BookingsState state) {
    final all = [...state.pending, ...state.queue, ...state.history];
    return all.firstWhere(
      (b) => b.id == widget.booking.id,
      orElse: () => widget.booking,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BusyErrorListener<BookingsCubit, BookingsState>(
      isBusy: (state) => state.updatingBookingId != null,
      errorMessage: (state) => state.errorMessage,
      child: BlocBuilder<BookingsCubit, BookingsState>(
        builder: (context, state) {
          final current = _resolve(state);

          return Scaffold(
            appBar: AppTopBar(title: current.code),
            body: RefreshIndicator(
              onRefresh: _refresh,
              child: ListView(
                padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 24.h),
                children: [
                  _buildHeader(context, current),
                  SectionTitle(title: S().bookingDetailsTitle),
                  BookingInfoCard(booking: current),
                  if (!current.billingLocked) ...[
                    SizedBox(height: 12.h),
                    OutlinedButton.icon(
                      onPressed: () => EditBillSheet.show(context, current),
                      icon: Icon(Icons.receipt_long_outlined, size: 18.r),
                      label: Text(S().editBillAction),
                    ),
                  ],
                  SizedBox(height: 20.h),
                  BookingActions(booking: current),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeader(BuildContext context, Booking booking) {
    return Row(
      children: [
        AvatarCircle(
          initials: booking.customerName.isEmpty
              ? S().avatarFallback
              : booking.customerName.substring(0, 1),
          size: 52.r,
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                booking.customerName,
                style: TextStyle(
                  fontSize: 15.sp,
                  color: context.colorScheme.onSurface,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                booking.customerPhone,
                style: TextStyle(
                  fontSize: 11.5.sp,
                  color: context.colorScheme.onSurfaceVariant,
                ),
              ),
              if (booking.barberName.isNotEmpty) ...[
                SizedBox(height: 4.h),
                Text(
                  booking.barberName,
                  style: TextStyle(
                    fontSize: 11.sp,
                    color: context.semantic.info,
                  ),
                ),
              ],
            ],
          ),
        ),
        StatusBadge(label: booking.status.label, tone: booking.status.tone),
      ],
    );
  }
}
