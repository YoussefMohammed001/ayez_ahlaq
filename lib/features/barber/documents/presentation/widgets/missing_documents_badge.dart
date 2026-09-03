import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../shared/widgets/count_badge.dart';
import '../manager/barber_documents_cubit.dart';
import '../manager/barber_documents_state.dart';

class MissingDocumentsBadge extends StatelessWidget {
  const MissingDocumentsBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BarberDocumentsCubit, BarberDocumentsState>(
      buildWhen: (previous, current) =>
          previous.missingRequiredCount != current.missingRequiredCount ||
          previous.missingOptionalCount != current.missingOptionalCount,
      builder: (context, state) => CountBadge(
        count: state.missingRequiredCount + state.missingOptionalCount,
        color: state.missingRequiredCount > 0
            ? null
            : context.semantic.accentStrong,
      ),
    );
  }
}
