import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/helpers/alerts.dart';
import '../../../../../generated/l10n.dart';
import '../../domain/entities/merchant_member.dart';
import '../manager/merchant_member_detail_cubit.dart';
import 'edit_merchant_member_sheet.dart';
import 'set_member_salary_sheet.dart';

class MerchantMemberSheets {
  const MerchantMemberSheets._();

  static void edit(BuildContext context, MerchantMember member) {
    final cubit = context.read<MerchantMemberDetailCubit>();

    EditMerchantMemberSheet.show(
      context,
      member: member,
      onSubmit: (name, phone) async {
        final saved = await cubit.updateMember(name: name, phoneNumber: phone);
        if (saved) showSuccess(S().memberSaved);
      },
    );
  }

  static void salary(BuildContext context, MerchantMember member) {
    final cubit = context.read<MerchantMemberDetailCubit>();

    SetMemberSalarySheet.show(
      context,
      amount: member.salary,
      onSubmit: (amount) async {
        final saved = await cubit.setSalary(amount);
        if (saved) showSuccess(S().salarySaved);
      },
    );
  }
}
