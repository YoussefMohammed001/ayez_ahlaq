import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../../../core/routes/route_paths.dart';
import '../../../../../core/widgets/app_empty_state.dart';
import '../../../../../core/widgets/app_top_bar.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../generated/l10n.dart';
import '../manager/booking_flow_cubit.dart';
import '../manager/booking_flow_state.dart';

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
    final formatted = DateFormat('yyyy-MM-dd').format(_selectedDate);
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
              label: Text(DateFormat('yyyy-MM-dd').format(_selectedDate)),
            ),
          ),
          Expanded(
            child: BlocBuilder<BookingFlowCubit, BookingFlowState>(
              builder: (context, state) {
                if (state.status == BookingFlowStatus.loadingSlots) {
                  return const Center(child: CircularProgressIndicator());
                }

                final perBarber = state.slots?.perBarber ?? const [];
                final matches = perBarber.where((b) => b.barberId == state.barberId);
                final slots = state.autoSelect
                    ? state.slots?.anyBarberSlots ?? const []
                    : (matches.isEmpty ? const [] : matches.first.slots);

                if (slots.isEmpty) {
                  return AppEmptyState(icon: Icons.event_busy_rounded, title: S().noSlotsAvailable);
                }

                return GridView.builder(
                  padding: EdgeInsets.fromLTRB(20.w, 14.h, 20.w, 24.h),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 10.h,
                    crossAxisSpacing: 10.w,
                    childAspectRatio: 2.2,
                  ),
                  itemCount: slots.length,
                  itemBuilder: (_, index) {
                    final slot = slots[index];
                    final selected = state.slotTime == slot;
                    return _SlotChip(
                      label: slot,
                      selected: selected,
                      onTap: () {
                        context.read<BookingFlowCubit>().selectSlotTime(slot);
                        context.push(Routes.customerBookingSummaryScreen);
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _SlotChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _SlotChip({required this.label, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final scheme = context.colorScheme;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected ? scheme.primary : scheme.surfaceContainer,
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: selected ? scheme.primary : scheme.outline),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12.5.sp,
            fontWeight: FontWeight.w700,
            color: selected ? scheme.surfaceContainerLowest : scheme.onSurface,
          ),
        ),
      ),
    );
  }
}
