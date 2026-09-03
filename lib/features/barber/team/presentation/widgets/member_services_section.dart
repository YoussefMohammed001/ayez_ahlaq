import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/app_error_state.dart';
import '../../../../../core/widgets/section_title.dart';
import '../../../../../generated/l10n.dart';
import '../../../services/domain/entities/barber_service.dart';
import '../../../services/presentation/widgets/barber_service_row.dart';
import '../../../services/presentation/widgets/service_form_sheet.dart';
import '../manager/member_services_cubit.dart';
import '../manager/member_services_state.dart';

class MemberServicesSection extends StatelessWidget {
  const MemberServicesSection({super.key});

  Future<void> _openForm(
    BuildContext context,
    MemberServicesState state, {
    BarberService? existing,
  }) {
    final cubit = context.read<MemberServicesCubit>();

    return ServiceFormSheet.show(
      context,
      catalog: state.catalog,
      isSubmitting: state.isSubmitting,
      existing: existing,
      onSubmit: (service) => existing == null
          ? cubit.createService(service)
          : cubit.updateService(service),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MemberServicesCubit, MemberServicesState>(
      builder: (context, state) {
        final cubit = context.read<MemberServicesCubit>();

        if (state.status == MemberServicesStatus.loading && state.services.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.status == MemberServicesStatus.failure && state.services.isEmpty) {
          return AppErrorState(
            compact: true,
            message: state.errorMessage,
            onRetry: () => cubit.loadServices(state.memberId!),
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionTitle(
              title: S().memberServicesTitle,
              actionLabel: S().addServiceTitle,
              onAction: () => _openForm(context, state),
            ),
            for (final service in state.services)
              BarberServiceRow(
                service: service,
                onToggleActive: (value) =>
                    cubit.updateService(service.copyWith(active: value)),
                onEdit: () => _openForm(context, state, existing: service),
                onDelete: () => cubit.deleteService(service.id),
              ),
            SizedBox(height: 8.h),
          ],
        );
      },
    );
  }
}
