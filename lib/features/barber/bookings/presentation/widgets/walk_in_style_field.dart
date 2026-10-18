import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../generated/l10n.dart';
import '../../../services/presentation/manager/shop_haircut_styles_cubit.dart';
import '../../../services/presentation/manager/shop_haircut_styles_state.dart';
import 'walk_in_dropdown_field.dart';

class WalkInStyleField extends StatelessWidget {
  final int? serviceId;
  final int? value;
  final ValueChanged<int?> onChanged;

  const WalkInStyleField({
    super.key,
    required this.serviceId,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = context.colorScheme;

    return BlocBuilder<ShopHaircutStylesCubit, ShopHaircutStylesState>(
      builder: (_, state) {
        final styles = state.styles
            .where((s) => s.active && s.serviceTypeId == serviceId)
            .toList();
        if (styles.isEmpty) return const SizedBox.shrink();

        final selected = styles.any((s) => s.id == value) ? value : null;

        return Padding(
          padding: EdgeInsets.only(top: 10.h),
          child: WalkInDropdownField<int>(
            key: ValueKey(serviceId),
            value: selected,
            hint: S().chooseStyleTitle,
            onChanged: onChanged,
            validator: (_) => null,
            items: [
              for (final style in styles)
                DropdownMenuItem(
                  value: style.id,
                  child: Text(
                    style.priceDelta == 0
                        ? style.name
                        : '${style.name} (${style.priceDelta > 0 ? '+' : ''}${style.priceDelta})',
                    style: TextStyle(fontSize: 13.5.sp, color: scheme.onSurface),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
