import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/app_cubit/app_cubit.dart';
import '../../../core/cache/preferences_storage/preferences_storage.dart';
import '../../../core/di/services_locator.dart';
import '../../../core/widgets/option_tile.dart';
import '../../../core/widgets/section_title.dart';
import '../../../generated/l10n.dart';

class LanguageSheet extends StatelessWidget {
  const LanguageSheet({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (_) => BlocProvider.value(
        value: context.read<AppCubit>(),
        child: const LanguageSheet(),
      ),
    );
  }

  void _select(BuildContext context, String code) {
    context.read<AppCubit>().setLanguage(code);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final current = sl<PreferencesStorage>().getCurrentLanguage();

    return Padding(
      padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 24.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionTitle(title: S().chooseLanguage),
          OptionTile(
            label: S().arabic,
            icon: Icons.translate_rounded,
            selected: current == 'ar',
            onTap: () => _select(context, 'ar'),
          ),
          OptionTile(
            label: S().english,
            icon: Icons.translate_rounded,
            selected: current == 'en',
            onTap: () => _select(context, 'en'),
          ),
        ],
      ),
    );
  }
}
