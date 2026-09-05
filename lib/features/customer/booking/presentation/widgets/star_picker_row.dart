import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/extensions/ext_theme.dart';

class StarPickerRow extends StatelessWidget {
  final int stars;
  final ValueChanged<int> onChanged;

  const StarPickerRow({super.key, required this.stars, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (var i = 1; i <= 5; i++)
          GestureDetector(
            onTap: () => onChanged(i),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: Icon(
                i <= stars ? Icons.star_rounded : Icons.star_border_rounded,
                size: 34.r,
                color: context.semantic.accentStrong,
              ),
            ),
          ),
      ],
    );
  }
}
