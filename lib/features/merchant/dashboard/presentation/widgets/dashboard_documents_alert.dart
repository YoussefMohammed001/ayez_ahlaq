import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/routes/route_paths.dart';
import '../../../../../shared/widgets/documents/required_documents_alert.dart';
import '../../../documents/presentation/manager/merchant_documents_cubit.dart';
import '../../../documents/presentation/manager/merchant_documents_state.dart';
import 'dashboard_all_clear.dart';

class DashboardDocumentsAlert extends StatelessWidget {
  final bool showAllClear;

  const DashboardDocumentsAlert({super.key, this.showAllClear = false});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MerchantDocumentsCubit, MerchantDocumentsState>(
      buildWhen: (previous, current) =>
          previous.missingRequiredCount != current.missingRequiredCount ||
          previous.missingOptionalCount != current.missingOptionalCount,
      builder: (context, state) {
        final missing =
            state.missingRequiredCount + state.missingOptionalCount;

        if (missing <= 0) {
          return showAllClear
              ? const DashboardAllClear()
              : const SizedBox.shrink();
        }

        return RequiredDocumentsAlert(
          requiredCount: state.missingRequiredCount,
          optionalCount: state.missingOptionalCount,
          onTap: () => context.push(Routes.merchantDocumentsScreen),
        );
      },
    );
  }
}
