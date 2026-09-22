import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/helpers/show_confirm_dialog.dart';
import '../../../../../generated/l10n.dart';
import '../../domain/entities/barber_service.dart';
import '../../domain/entities/own_service.dart';
import '../manager/barber_services_cubit.dart';
import '../manager/own_services_cubit.dart';
import '../widgets/own_service_form_sheet.dart';
import '../widgets/service_form_sheet.dart';

class BarberServicesActions {
  const BarberServicesActions();

  Future<void> openForm(BuildContext context, {BarberService? existing}) {
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

  Future<void> confirmDeleteService(BuildContext context, BarberService service) async {
    final confirmed = await showConfirmDialog(
      context,
      title: S().deleteServiceTitle,
      message: S().deleteServiceConfirm,
      confirmLabel: S().delete,
      icon: Icons.delete_outline_rounded,
    );

    if (confirmed) await context.read<BarberServicesCubit>().deleteService(service.id);
  }

  Future<void> confirmDeleteOwnService(BuildContext context, OwnService service) async {
    final confirmed = await showConfirmDialog(
      context,
      title: S().deleteOwnServiceTitle,
      message: S().deleteOwnServiceConfirm,
      confirmLabel: S().delete,
      icon: Icons.delete_outline_rounded,
    );

    if (confirmed) await context.read<OwnServicesCubit>().deleteOwnService(service.id);
  }

  Future<void> openOwnServiceForm(BuildContext context) {
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

  Future<void> refresh(BuildContext context) async {
    await Future.wait([
      context.read<BarberServicesCubit>().loadServices(),
      context.read<OwnServicesCubit>().loadOwnServices(),
    ]);
  }
}
