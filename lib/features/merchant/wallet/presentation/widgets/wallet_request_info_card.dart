import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/app_card.dart';
import '../../../../../core/widgets/info_row.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../generated/l10n.dart';
import '../../domain/entities/wallet_request.dart';
import '../../domain/entities/wallet_request_type.dart';
import 'wallet_request_status_chip.dart';

class WalletRequestInfoCard extends StatelessWidget {
  final WalletRequest request;

  const WalletRequestInfoCard({super.key, required this.request});

  @override
  Widget build(BuildContext context) {
    final isDeposit = request.type == WalletRequestType.deposit;

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              WalletRequestStatusChip(status: request.status),
              Text(
                S().currencyEgp(request.amount),
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w800,
                  color: context.colorScheme.onSurface,
                ),
              ),
            ],
          ),
          SizedBox(height: 6.h),
          InfoRow(
            icon: Icons.swap_vert_rounded,
            label: S().walletRequestTypeLabel,
            value: isDeposit
                ? S().walletRequestTypeDeposit
                : S().walletRequestTypeWithdraw,
          ),
          if (request.note != null && request.note!.isNotEmpty)
            InfoRow(
              icon: Icons.notes_rounded,
              label: S().walletRequestNoteLabel,
              value: request.note!,
            ),
          if (request.decisionNote != null && request.decisionNote!.isNotEmpty)
            InfoRow(
              icon: Icons.comment_outlined,
              label: S().walletRequestDecisionNoteLabel,
              value: request.decisionNote!,
            ),
          if (request.decidedByName != null)
            InfoRow(
              icon: Icons.person_outline_rounded,
              label: S().walletRequestDecidedByLabel,
              value: request.decidedByName!,
            ),
          if (request.decidedAt != null)
            InfoRow(
              icon: Icons.event_available_outlined,
              label: S().walletRequestDecidedAtLabel,
              value: request.decidedAt!.toLocal().toString(),
              showDivider: false,
            ),
        ],
      ),
    );
  }
}
