import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/helpers/show_confirm_dialog.dart';
import '../../../../../core/widgets/app_error_state.dart';
import '../../../../../core/widgets/app_top_bar.dart';
import '../../../../../core/widgets/section_title.dart';
import '../../../../../shared/widgets/busy_error_listener.dart';
import '../../../../../generated/l10n.dart';
import '../../domain/entities/barber_service.dart';
import '../../domain/entities/own_service.dart';
import '../manager/barber_services_cubit.dart';
import '../manager/barber_services_state.dart';
import '../manager/own_services_cubit.dart';
import '../manager/own_services_state.dart';
import '../widgets/barber_services_list.dart';
import '../widgets/own_service_form_sheet.dart';
import '../widgets/own_services_section.dart';
import '../widgets/service_form_sheet.dart';

class BarberServicesScreen extends StatefulWidget {
  const BarberServicesScreen({super.key});

  @override
  State<BarberServicesScreen> createState() => _BarberServicesScreenState();
}

class _BarberServicesScreenState extends State<BarberServicesScreen> {
  @override
  void initState() {
    super.initState();
    context.read<OwnServicesCubit>().loadOwnServices();
  }

  Future<void> _openForm(BuildContext context, {BarberService? existing}) {
    final cubit = context.read<BarberServicesCubit>();

    return ServiceFormSheet.show(
      context,
      catalog: cubit.state.catalog,
      isSubmitting: cubit.state.isSubmitting,
      existing: existing,
      onSubmit: (service) => existing == null
          ? cubit.createService(service)
          : cubit.updateService(service),
    );
  }

  Future<void> _confirmDeleteService(BuildContext context, BarberService service) async {
    final confirmed = await showConfirmDialog(
      context,
      title: S().deleteServiceTitle,
      message: S().deleteServiceConfirm,
      confirmLabel: S().delete,
      icon: Icons.delete_outline_rounded,
    );

    if (confirmed) await context.read<BarberServicesCubit>().deleteService(service.id);
  }

  Future<void> _confirmDeleteOwnService(BuildContext context, OwnService service) async {
    final confirmed = await showConfirmDialog(
      context,
      title: S().deleteOwnServiceTitle,
      message: S().deleteOwnServiceConfirm,
      confirmLabel: S().delete,
      icon: Icons.delete_outline_rounded,
    );

    if (confirmed) await context.read<OwnServicesCubit>().deleteOwnService(service.id);
  }

  Future<void> _openOwnServiceForm(BuildContext context) {
    final ownCubit = context.read<OwnServicesCubit>();
    final servicesCubit = context.read<BarberServicesCubit>();

    return OwnServiceFormSheet.show(
      context,
      isSubmitting: ownCubit.state.isSubmitting,
      onSubmit: (name, description) async {
        final created = await ownCubit.createOwnService(name, description);
        if (created) await servicesCubit.loadServices();
        return created;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BusyErrorListener<BarberServicesCubit, BarberServicesState>(
      isBusy: (state) => state.isSubmitting || state.isDeleting,
      errorMessage: (state) => state.errorMessage,
      child: BusyErrorListener<OwnServicesCubit, OwnServicesState>(
        isBusy: (state) => state.isSubmitting || state.isDeleting,
        errorMessage: (state) => state.errorMessage,
        child: Scaffold(
          appBar: AppTopBar(
            title: S().servicesTitle,
            trailing: Builder(
              builder: (context) => IconButton(
                icon: const Icon(Icons.add_rounded),
                onPressed: () => _openForm(context),
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

              return ListView(
                padding: EdgeInsets.fromLTRB(20.w, 14.h, 20.w, 24.h),
                children: [
                  BarberServicesList(
                    onEdit: (service) => _openForm(context, existing: service),
                    onDelete: (service) => _confirmDeleteService(context, service),
                  ),
                  SectionTitle(
                    title: S().ownServicesTitle,
                    actionLabel: S().addOwnServiceTitle,
                    onAction: () => _openOwnServiceForm(context),
                  ),
                  OwnServicesSection(
                    onDelete: (service) => _confirmDeleteOwnService(context, service),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
