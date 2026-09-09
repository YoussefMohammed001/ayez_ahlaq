import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/extensions/ext_theme.dart';

class WalkInDropdownField<T> extends StatelessWidget {
  final T? value;
  final String hint;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?> onChanged;
  final String? Function(T? value) validator;

  const WalkInDropdownField({
    super.key,
    required this.value,
    required this.hint,
    required this.items,
    required this.onChanged,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = context.colorScheme;

    return FormField<T>(
      initialValue: value,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
      builder: (state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              decoration: BoxDecoration(
                color: scheme.surfaceContainer,
                borderRadius: BorderRadius.circular(14.r),
                border: Border.all(
                  color: state.hasError ? scheme.error : scheme.outline,
                ),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<T>(
                  isExpanded: true,
                  value: value,
                  hint: Text(
                    hint,
                    style: TextStyle(fontSize: 13.5.sp, color: Theme.of(context).hintColor),
                  ),
                  items: items,
                  onChanged: (v) {
                    state.didChange(v);
                    onChanged(v);
                  },
                ),
              ),
            ),
            if (state.hasError) ...[
              SizedBox(height: 4.h),
              Text(
                state.errorText!,
                style: TextStyle(fontSize: 11.sp, color: scheme.error),
              ),
            ],
          ],
        );
      },
    );
  }
}
