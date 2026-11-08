import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/di/sl.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../core/helpers/alerts.dart';
import '../../../../../core/theme/styles.dart';
import '../../../../../core/widgets/app_error_state.dart';
import '../../../../../core/widgets/app_text_field.dart';
import '../../../../../core/widgets/primary_cta_button.dart';
import '../../../../../core/widgets/section_title.dart';
import '../../../../../generated/l10n.dart';
import '../helpers/deduction_grace_validator.dart';
import '../manager/deduction_grace_cubit.dart';
import '../manager/deduction_grace_state.dart';

class GraceSettingSheet extends StatefulWidget {
  const GraceSettingSheet({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => BlocProvider(
        create: (_) => sl<DeductionGraceCubit>()..load(),
        child: const GraceSettingSheet(),
      ),
    );
  }

  @override
  State<GraceSettingSheet> createState() => _GraceSettingSheetState();
}

class _GraceSettingSheetState extends State<GraceSettingSheet> {
  final _formKey = GlobalKey<FormState>();
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    final state = context.read<DeductionGraceCubit>().state;
    if (state.status == DeductionGraceStatus.success) {
      _controller.text = '${state.minutes}';
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _save(DeductionGraceCubit cubit) async {
    if (!_formKey.currentState!.validate()) return;

    final saved = await cubit.save(
      DeductionGraceValidator.parse(_controller.text)!,
    );
    if (!mounted) return;

    if (saved) {
      showSuccess(S().graceSaved);
      Navigator.of(context).pop();
    } else {
      showError(cubit.state.errorMessage ?? S().somethingWentWrong);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 24.h),
        decoration: BoxDecoration(
          color: context.colorScheme.surface,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
        child: BlocConsumer<DeductionGraceCubit, DeductionGraceState>(
          listenWhen: (previous, current) =>
              previous.status != DeductionGraceStatus.success &&
              current.status == DeductionGraceStatus.success,
          listener: (_, state) => _controller.text = '${state.minutes}',
          builder: (context, state) {
            final cubit = context.read<DeductionGraceCubit>();

            if (state.status == DeductionGraceStatus.failure) {
              return AppErrorState(
                compact: true,
                message: state.errorMessage,
                onRetry: cubit.load,
              );
            }

            return Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SectionTitle(title: S().graceTitle),
                  Text(
                    S().graceDescription,
                    style: font12w400.copyWith(
                      color: context.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  SizedBox(height: 14.h),
                  AppTextField(
                    controller: _controller,
                    hint: S().graceLabel,
                    isNumber: true,
                    validator: DeductionGraceValidator.validate,
                  ),
                  SizedBox(height: 20.h),
                  PrimaryCtaButton(
                    label: S().save,
                    isLoading: state.isSaving,
                    onPressed: state.status == DeductionGraceStatus.success
                        ? () => _save(cubit)
                        : null,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
