import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../core/helpers/alerts.dart';
import '../../../../../core/theme/styles.dart';
import '../../../../../core/widgets/app_card.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../shared/widgets/switch_row_widget.dart';
import '../manager/barber_profile_cubit.dart';
import '../manager/barber_profile_state.dart';

class ServesClientsCard extends StatelessWidget {
  const ServesClientsCard({super.key});

  Future<void> _onChanged(BuildContext context, bool value) async {
    final cubit = context.read<BarberProfileCubit>();
    final updated = await cubit.updateServesClients(value);

    if (updated) {
      showSuccess(S().servesClientsUpdated);
      return;
    }

    final message = cubit.state.errorMessage;
    if (message != null) showError(message);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BarberProfileCubit, BarberProfileState>(
      builder: (context, state) {
        final profile = state.profile;
        if (profile == null || !profile.owner) return const SizedBox.shrink();

        final serves = profile.servesClients;

        return AppCard(
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SwitchRow(
                label: S().servesClientsLabel,
                value: serves,
                cs: context.colorScheme,
                onChanged: state.isSubmitting
                    ? (_) {}
                    : (value) => _onChanged(context, value),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 10.h),
                child: Text(
                  serves ? S().servesClientsOnHint : S().servesClientsOffHint,
                  style: font12w400.copyWith(
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
