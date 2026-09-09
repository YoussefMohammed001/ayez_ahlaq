import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/section_title.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../shared/payment_methods/payment_methods_state.dart';
import '../../../payment_methods/presentation/manager/payment_methods_cubit.dart';

class StorePaymentMethodsSection extends StatelessWidget {
  final String selectedCode;
  final ValueChanged<String> onChanged;

  const StorePaymentMethodsSection({
    super.key,
    required this.selectedCode,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaymentMethodsCubit, PaymentMethodsState>(
      builder: (context, state) {
        if (state.methods.isEmpty) return const SizedBox.shrink();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionTitle(title: S().paymentMethodsSectionTitle),
            Wrap(
              spacing: 8.w,
              runSpacing: 8.h,
              children: state.methods
                  .map(
                    (method) => ChoiceChip(
                      label: Text(method.label),
                      selected: selectedCode == method.code,
                      onSelected: (_) => onChanged(method.code),
                    ),
                  )
                  .toList(),
            ),
          ],
        );
      },
    );
  }
}
