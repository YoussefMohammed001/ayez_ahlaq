import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/app_cubit/app_cubit.dart';
import '../../../core/widgets/option_tile.dart';
import '../../../core/widgets/section_title.dart';
import '../../../generated/l10n.dart';

class ThemeSheet extends StatelessWidget {
  const ThemeSheet({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (_) => BlocProvider.value(
        value: context.read<AppCubit>(),
        child: const ThemeSheet(),
      ),
    );
  }

  void _select(BuildContext context, ThemeMode mode) {
    context.read<AppCubit>().setTheme(mode);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final current = context.read<AppCubit>().themeMode;

    return Padding(
      padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 24.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionTitle(title: S().chooseTheme),
          OptionTile(
            label: S().themeDark,
            icon: Icons.dark_mode_outlined,
            selected: current == ThemeMode.dark,
            onTap: () => _select(context, ThemeMode.dark),
          ),
          OptionTile(
            label: S().themeLight,
            icon: Icons.light_mode_outlined,
            selected: current == ThemeMode.light,
            onTap: () => _select(context, ThemeMode.light),
          ),
        ],
      ),
    );
  }
}
