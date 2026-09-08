import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/widgets/section_title.dart';
import '../../../../../generated/l10n.dart';
import '../../../services/presentation/manager/barber_services_cubit.dart';
import '../../../services/presentation/manager/barber_services_state.dart';
import '../../../team/presentation/manager/barber_team_cubit.dart';
import '../../../team/presentation/manager/barber_team_state.dart';
import 'walk_in_barber_field.dart';
import 'walk_in_service_field.dart';

class WalkInAssignmentFields extends StatelessWidget {
  final bool isOwner;
  final int? serviceId;
  final int? barberId;
  final ValueChanged<int?> onServiceChanged;
  final ValueChanged<int?> onBarberChanged;

  const WalkInAssignmentFields({
    super.key,
    required this.isOwner,
    required this.serviceId,
    required this.barberId,
    required this.onServiceChanged,
    required this.onBarberChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BlocBuilder<BarberServicesCubit, BarberServicesState>(
          builder: (_, state) => WalkInServiceField(
            services: state.services,
            value: serviceId,
            onChanged: onServiceChanged,
          ),
        ),
        if (isOwner) ...[
          SectionTitle(title: S().walkInBarberLabel),
          BlocBuilder<BarberTeamCubit, BarberTeamState>(
            builder: (_, state) => WalkInBarberField(
              members: state.members.where((m) => !m.owner).toList(),
              value: barberId,
              onChanged: onBarberChanged,
            ),
          ),
        ],
      ],
    );
  }
}
