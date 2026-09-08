import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/extensions/ext_theme.dart';

class BarberStoreFab extends StatelessWidget {
  final VoidCallback onPressed;

  const BarberStoreFab({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 58.r,
      height: 58.r,
      child: FloatingActionButton(
        heroTag: 'barberStoreFab',
        onPressed: onPressed,
        backgroundColor: context.semantic.accentStrong,
        foregroundColor: context.colorScheme.surfaceContainerLowest,
        elevation: 4,
        shape: const CircleBorder(),
        child: Icon(Icons.shopping_bag_outlined, size: 26.r),
      ),
    );
  }
}
