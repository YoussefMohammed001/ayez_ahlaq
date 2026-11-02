import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../../../core/routes/route_paths.dart';
import '../../../../../core/widgets/app_empty_state.dart';
import '../../../../../core/widgets/app_top_bar.dart';
import '../../../../../generated/l10n.dart';
import '../manager/booking_flow_cubit.dart';
import '../manager/booking_flow_state.dart';
import '../widgets/slot_chip.dart';
import '../widgets/slot_service_duration_note.dart';

class ChooseTimeScreen extends StatefulWidget {
  const ChooseTimeScreen({super.key});

  @override
  State<ChooseTimeScreen> createState() => _ChooseTimeScreenState();
}

class _ChooseTimeScreenState extends State<ChooseTimeScreen> {
  late DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _loadSlots();
  }

  void _loadSlots() {
    final formatted = DateFormat('yyyy-MM-dd', 'en').format(_selectedDate);
    context.read<BookingFlowCubit>().loadSlots(formatted);
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 60)),
    );
    if (picked == null) return;
    setState(() => _selectedDate = picked);
    _loadSlots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppTopBar(title: S().chooseTimeTitle),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(20.w, 14.h, 20.w, 4.h),
            child: OutlinedButton.icon(
              onPressed: _pickDate,
              icon: const Icon(Icons.calendar_today_rounded),
              label: Text(DateFormat('yyyy-MM-dd', 'en').format(_selectedDate)),
            ),
          ),
          Expanded(
            child: BlocBuilder<BookingFlowCubit, BookingFlowState>(
              builder: (context, state) {
                if (state.status == BookingFlowStatus.loadingSlots) {
                  return const Center(child: CircularProgressIndicator());
                }

                final perBarber = state.slots?.perBarber ?? const [];
                final barber = perBarber
                    .where((b) => b.barberId == state.barberId)
                    .firstOrNull;
                final slots = state.autoSelect
                    ? state.slots?.anyBarberSlots ?? const []
                    : barber?.slots ?? const [];
                final durations = state.autoSelect
                    ? perBarber.map((b) => b.durationMinutes).toSet()
                    : {?barber?.durationMinutes};
                final serviceMinutes = durations.length == 1
                    ? durations.first
                    : null;

                return Column(
                  children: [
                    if (slots.isNotEmpty && serviceMinutes != null)
                      SlotServiceDurationNote(minutes: serviceMinutes),
                    Expanded(
                      child: slots.isEmpty
                          ? AppEmptyState(
                              icon: Icons.event_busy_rounded,
                              title: S().noSlotsAvailable,
                            )
                          : GridView.builder(
                              padding: EdgeInsets.fromLTRB(
                                20.w,
                                14.h,
                                20.w,
                                16.h,
                              ),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    mainAxisSpacing: 10.h,
                                    crossAxisSpacing: 10.w,
                                    childAspectRatio: 2.2,
                                  ),
                              itemCount: slots.length,
                              itemBuilder: (_, index) {
                                final slot = slots[index];
                                return SlotChip(
                                  time: slot,
                                  selected: state.slotTime == slot,
                                  onTap: () {
                                    context
                                        .read<BookingFlowCubit>()
                                        .selectSlotTime(slot);
                                    context.push(
                                      Routes.customerBookingSummaryScreen,
                                    );
                                  },
                                );
                              },
                            ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
