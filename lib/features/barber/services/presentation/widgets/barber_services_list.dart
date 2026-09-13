import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/barber_service.dart';
import '../manager/barber_services_cubit.dart';
import '../manager/barber_services_state.dart';
import 'barber_service_row.dart';

class BarberServicesList extends StatelessWidget {
  final ValueChanged<BarberService> onEdit;
  final ValueChanged<BarberService> onDelete;

  const BarberServicesList({
    super.key,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BarberServicesCubit, BarberServicesState>(
      builder: (context, state) {
        final cubit = context.read<BarberServicesCubit>();

        return Column(
          children: [
            for (final service in state.services)
              BarberServiceRow(
                service: service,
                onToggleActive: (value) => cubit.updateService(
                  service.copyWith(active: value),
                ),
                onEdit: () => onEdit(service),
                onDelete: () => onDelete(service),
              ),
          ],
        );
      },
    );
  }
}
