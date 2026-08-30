import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/app_top_bar.dart';
import '../../../../../core/widgets/app_empty_state.dart';
import '../../../../../core/widgets/app_error_state.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../core/helpers/show_confirm_dialog.dart';
import '../manager/merchant_phones_cubit.dart';
import '../manager/merchant_phones_state.dart';
import '../widgets/add_phone_sheet.dart';
import '../widgets/phone_row.dart';
import '../../../../../core/widgets/list_skeleton.dart';
import '../../../../../core/extensions/ext_theme.dart';

class MerchantPhonesScreen extends StatelessWidget {
  const MerchantPhonesScreen({super.key});

  Future<void> _confirmRemove(BuildContext context, int id) async {
    final cubit = context.read<MerchantPhonesCubit>();
    final confirmed = await showConfirmDialog(
      context,
      title: S().deletePhone,
      message: S().deletePhoneConfirm,
      confirmLabel: S().delete,
      icon: Icons.delete_outline_rounded,
    );

    if (confirmed) await cubit.deletePhone(id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppTopBar(
        title: S().extraPhones,
        trailing: IconButton(
          icon: Icon(Icons.add, color: context.semantic.accentStrong, size: 22.r),
          onPressed: () => AddPhoneSheet.show(context),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(20.w, 14.h, 20.w, 0),
            child: Text(
              S().extraPhonesNote,
              style: TextStyle(
                fontSize: 12.5.sp,
                color: context.colorScheme.onSurfaceVariant,
                height: 1.8,
              ),
            ),
          ),
          SizedBox(height: 16.h),
          Expanded(child: _buildBody()),
        ],
      ),
    );
  }

  Widget _buildBody() {
    return BlocBuilder<MerchantPhonesCubit, MerchantPhonesState>(
      builder: (context, state) {
        if (state.status == PhonesStatus.loading && state.phones.isEmpty) {
          return const ListSkeleton();
        }

        if (state.status == PhonesStatus.failure && state.phones.isEmpty) {
          return AppErrorState(
            message: state.errorMessage,
            onRetry: context.read<MerchantPhonesCubit>().loadPhones,
          );
        }

        if (state.phones.isEmpty) {
          return AppEmptyState(
            icon: Icons.call_outlined,
            title: S().noExtraPhones,
            actionLabel: S().add,
            onAction: () => AddPhoneSheet.show(context),
          );
        }

        return ListView.builder(
          padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 24.h),
          itemCount: state.phones.length,
          itemBuilder: (_, index) {
            final phone = state.phones[index];
            return PhoneRow(
              phone: phone,
              onRemove: () => _confirmRemove(context, phone.id),
            );
          },
        );
      },
    );
  }
}
