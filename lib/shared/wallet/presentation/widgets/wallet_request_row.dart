import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/helpers/relative_date_label.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/extensions/ext_theme.dart';
import '../../../../generated/l10n.dart';
import '../../domain/entities/wallet_request.dart';
import '../../domain/entities/wallet_request_type.dart';
import 'wallet_request_status_chip.dart';

class WalletRequestRow extends StatelessWidget {
  final WalletRequest request;
  final VoidCallback? onTap;

  const WalletRequestRow({super.key, required this.request, this.onTap});

  @override
  Widget build(BuildContext context) {
    final scheme = context.colorScheme;
    final isDeposit = request.type == WalletRequestType.deposit;
    final amountColor = isDeposit ? context.semantic.success : context.semantic.warning;
    final sign = isDeposit ? '+' : '-';

    return AppCard(
      margin: EdgeInsets.only(bottom: 10.h),
      onTap: onTap,
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  request.code,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w700, color: scheme.onSurface),
                ),
                SizedBox(height: 3.h),
                Text(
                  RelativeDateLabel.format(request.createdAt),
                  style: TextStyle(fontSize: 10.5.sp, color: scheme.onSurfaceVariant),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '$sign${S().currencyEgp(request.amount)}',
                style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w800, color: amountColor),
              ),
              SizedBox(height: 6.h),
              WalletRequestStatusChip(status: request.status),
            ],
          ),
        ],
      ),
    );
  }
}
