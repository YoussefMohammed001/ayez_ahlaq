import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/helpers/alerts.dart';
import '../../../../../core/widgets/app_error_state.dart';
import '../../../../../core/widgets/app_top_bar.dart';
import '../../../../../core/widgets/list_skeleton.dart';
import '../../../../../core/widgets/refreshable_state_view.dart';
import '../../../../../generated/l10n.dart';
import '../manager/booking_detail_cubit.dart';
import '../manager/booking_detail_state.dart';
import '../widgets/customer_booking_detail_card.dart';

class BookingDetailScreen extends StatefulWidget {
  final int bookingId;

  const BookingDetailScreen({super.key, required this.bookingId});

  @override
  State<BookingDetailScreen> createState() => _BookingDetailScreenState();
}

class _BookingDetailScreenState extends State<BookingDetailScreen> {
  @override
  void initState() {
    super.initState();
    context.read<BookingDetailCubit>().loadBooking(widget.bookingId);
  }

  Future<void> _cancel() async {
    final cubit = context.read<BookingDetailCubit>();
    final success = await cubit.cancelBooking(widget.bookingId);
    if (!mounted) return;
    if (success) {
      showSuccess(S().bookingCancelledMessage);
    } else if (cubit.state.errorMessage != null) {
      showError(cubit.state.errorMessage!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppTopBar(title: S().bookingDetailsTitle),
      body: BlocBuilder<BookingDetailCubit, BookingDetailState>(
        builder: (context, state) {
          final cubit = context.read<BookingDetailCubit>();
          Future<void> reload() => cubit.loadBooking(widget.bookingId);

          if (state.status == BookingDetailStatus.loading && state.booking == null) {
            return const ListSkeleton();
          }

          final booking = state.booking;
          if (state.status == BookingDetailStatus.failure && booking == null) {
            return RefreshableStateView(
              onRefresh: reload,
              child: AppErrorState(message: state.errorMessage, onRetry: reload),
            );
          }

          if (booking == null) return const SizedBox.shrink();

          return RefreshIndicator(
            onRefresh: reload,
            child: ListView(
              padding: EdgeInsets.fromLTRB(20.w, 14.h, 20.w, 24.h),
              children: [
                CustomerBookingDetailCard(booking: booking),
                if (booking.status.isCancellable) ...[
                  SizedBox(height: 20.h),
                  ElevatedButton(
                    onPressed: state.isCancelling ? null : _cancel,
                    child: state.isCancelling
                        ? SizedBox(
                            width: 18.r,
                            height: 18.r,
                            child: const CircularProgressIndicator(strokeWidth: 2),
                          )
                        : Text(S().cancelBooking),
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}
