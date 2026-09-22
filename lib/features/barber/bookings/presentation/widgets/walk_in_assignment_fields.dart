import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/widgets/section_title.dart';
import '../../../../../generated/l10n.dart';
import '../manager/walk_in_options_cubit.dart';
import '../manager/walk_in_options_state.dart';
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
    return BlocBuilder<WalkInOptionsCubit, WalkInOptionsState>(
      builder: (_, state) {
        final selectedOption =
            state.options.where((o) => o.serviceTypeId == serviceId).firstOrNull;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            WalkInServiceField(
              options: state.options,
              value: serviceId,
              onChanged: onServiceChanged,
            ),
            if (isOwner) ...[
              SectionTitle(title: S().walkInBarberLabel),
              WalkInBarberField(
                barbers: selectedOption?.barbers ?? const [],
                value: barberId,
                onChanged: onBarberChanged,
              ),
            ],
          ],
        );
      },
    );
  }
}
