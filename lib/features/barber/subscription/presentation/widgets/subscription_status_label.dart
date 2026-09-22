import 'package:flutter/material.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../generated/l10n.dart';
import '../../domain/entities/subscription_status.dart';

extension SubscriptionStatusLabel on SubscriptionStatus {
  String get label => switch (this) {
    SubscriptionStatus.active => S().planStatusActive,
    SubscriptionStatus.pending => S().planStatusPending,
    SubscriptionStatus.paused => S().planStatusPaused,
    SubscriptionStatus.unknown => S().planStatusUnknown,
  };

  Color colorOf(BuildContext context) => switch (this) {
    SubscriptionStatus.active => context.semantic.success,
    SubscriptionStatus.pending => context.semantic.warning,
    SubscriptionStatus.paused => context.semantic.warning,
    SubscriptionStatus.unknown => context.semantic.info,
  };
}
