import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/app_error_state.dart';
import '../../../../../core/widgets/app_top_bar.dart';
import '../../../../../generated/l10n.dart';
import '../../domain/entities/barber_service.dart';
import '../manager/barber_services_cubit.dart';
import '../manager/barber_services_state.dart';
import '../widgets/barber_service_row.dart';
import '../widgets/service_form_sheet.dart';

class BarberServicesScreen extends StatelessWidget {
  const BarberServicesScreen({super.key});

  Future<void> _openForm(
    BuildContext context,
    BarberServicesState state, {
    BarberService? existing,
  }) {
    final cubit = context.read<BarberServicesCubit>();

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
    return Scaffold(
      appBar: AppTopBar(
        title: S().servicesTitle,
        trailing: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.add_rounded),
            onPressed: () => _openForm(
              context,
              context.read<BarberServicesCubit>().state,
            ),
          ),
        ),
      ),
      body: BlocBuilder<BarberServicesCubit, BarberServicesState>(
        builder: (context, state) {
          if (state.status == BarberServicesStatus.loading && state.services.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.status == BarberServicesStatus.failure && state.services.isEmpty) {
            return AppErrorState(
              message: state.errorMessage,
              onRetry: context.read<BarberServicesCubit>().loadServices,
            );
          }

          final cubit = context.read<BarberServicesCubit>();

          return ListView(
            padding: EdgeInsets.fromLTRB(20.w, 14.h, 20.w, 24.h),
            children: [
              for (final service in state.services)
                BarberServiceRow(
                  service: service,
                  onToggleActive: (value) => cubit.updateService(
                    service.copyWith(active: value),
                  ),
                  onEdit: () => _openForm(context, state, existing: service),
                  onDelete: () => cubit.deleteService(service.id),
                ),
            ],
          );
        },
      ),
    );
  }
}
