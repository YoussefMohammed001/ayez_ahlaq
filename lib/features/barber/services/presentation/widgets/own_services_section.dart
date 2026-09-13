import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../generated/l10n.dart';
import '../../domain/entities/own_service.dart';
import '../manager/own_services_cubit.dart';
import '../manager/own_services_state.dart';
import 'own_service_row.dart';

class OwnServicesSection extends StatelessWidget {
  final ValueChanged<OwnService> onDelete;

  const OwnServicesSection({super.key, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OwnServicesCubit, OwnServicesState>(
      builder: (context, state) {
        if (state.status == OwnServicesStatus.loading && state.services.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.services.isEmpty) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 12.h),
            child: Text(S().noOwnServicesYet),
          );
        }

        return Column(
          children: [
            for (final service in state.services)
              OwnServiceRow(
                service: service,
                onDelete: () => onDelete(service),
              ),
          ],
        );
      },
    );
  }
}
