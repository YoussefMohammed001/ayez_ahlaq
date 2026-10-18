import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/helpers/alerts.dart';
import '../../../../../core/routes/route_paths.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../shared/widgets/success_screen_args.dart';
import '../manager/home_service_request_form_state.dart';

void handleHomeServiceFormSubmitted(
  BuildContext context,
  HomeServiceRequestFormState state,
) {
  if (state.status == HomeServiceRequestFormStatus.success) {
    context.go(
      Routes.successScreen,
      extra: SuccessScreenArgs(
        message: S().homeServiceRequestCreated,
        doneRoute: Routes.customerHomeServiceRequestsScreen,
      ),
    );
  }
  if (state.status == HomeServiceRequestFormStatus.failure &&
      state.errorMessage != null) {
    showError(state.errorMessage!);
  }
}
