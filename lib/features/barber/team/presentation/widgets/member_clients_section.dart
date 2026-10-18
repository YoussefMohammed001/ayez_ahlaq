import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/helpers/app_date_time.dart';
import '../../../../../core/widgets/app_empty_state.dart';
import '../../../../../core/widgets/app_error_state.dart';
import '../../../../../core/widgets/section_title.dart';
import '../../../../../generated/l10n.dart';
import '../manager/member_clients_cubit.dart';
import '../manager/member_clients_state.dart';
import 'member_client_row.dart';

class MemberClientsSection extends StatelessWidget {
  const MemberClientsSection({super.key});

  Future<void> _pickDateRange(BuildContext context, MemberClientsState state) async {
    final range = await showDateRangePicker(
      context: context,
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now(),
      initialDateRange: DateTimeRange(start: state.from, end: state.to),
    );

    if (range == null || !context.mounted) return;
    context.read<MemberClientsCubit>().setDateRange(range.start, range.end);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MemberClientsCubit, MemberClientsState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: SectionTitle(title: S().memberClientsTitle)),
                TextButton(
                  onPressed: () => _pickDateRange(context, state),
                  child: Text(
                    '${AppDateTime.formatDate(state.from)} - ${AppDateTime.formatDate(state.to)}',
                    style: TextStyle(fontSize: 11.5.sp),
                  ),
                ),
              ],
            ),
            if (state.status == MemberClientsStatus.loading)
              const Center(child: CircularProgressIndicator())
            else if (state.status == MemberClientsStatus.failure)
              AppErrorState(
                compact: true,
                message: state.errorMessage,
                onRetry: () => context.read<MemberClientsCubit>().setDateRange(
                  state.from,
                  state.to,
                ),
              )
            else if (state.clients.isEmpty)
              AppEmptyState(
                icon: Icons.people_outline,
                title: S().memberClientsEmpty,
                compact: true,
              )
            else
              for (final client in state.clients) MemberClientRow(client: client),
          ],
        );
      },
    );
  }
}
