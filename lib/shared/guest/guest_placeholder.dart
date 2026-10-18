import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/routes/route_paths.dart';
import '../../generated/l10n.dart';
import '../widgets/first_run_empty_state.dart';

class GuestPlaceholder extends StatelessWidget {
  const GuestPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FirstRunEmptyState(
          icon: Icons.person_outline_rounded,
          title: S().guestPlaceholderTitle,
          subtitle: S().guestPlaceholderSubtitle,
          ctaLabel: S().signIn,
          onCta: () => context.push(Routes.customerLoginScreen),
        ),
      ),
    );
  }
}
