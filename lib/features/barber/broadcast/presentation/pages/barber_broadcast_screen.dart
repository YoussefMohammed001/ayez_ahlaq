import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/helpers/alerts.dart';
import '../../../../../core/widgets/app_text_field.dart';
import '../../../../../core/widgets/app_top_bar.dart';
import '../../../../../core/widgets/primary_cta_button.dart';
import '../../../../../core/widgets/section_title.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../shared/widgets/busy_error_listener.dart';
import '../manager/barber_broadcast_cubit.dart';
import '../manager/barber_broadcast_state.dart';
import '../widgets/barber_broadcast_scope_selector.dart';

class BarberBroadcastScreen extends StatefulWidget {
  const BarberBroadcastScreen({super.key});

  @override
  State<BarberBroadcastScreen> createState() => _BarberBroadcastScreenState();
}

class _BarberBroadcastScreenState extends State<BarberBroadcastScreen> {
  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final title = _titleController.text.trim();
    final body = _bodyController.text.trim();
    if (title.isEmpty || body.isEmpty) return;

    final cubit = context.read<BarberBroadcastCubit>();
    final sent = await cubit.send(title: title, body: body);

    if (!mounted) return;

    if (sent) {
      showSuccess(S().broadcastSentSuccess);
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BusyErrorListener<BarberBroadcastCubit, BarberBroadcastState>(
      isBusy: (state) => state.status == BarberBroadcastStatus.sending,
      errorMessage: (state) => state.errorMessage,
      child: Scaffold(
        appBar: AppTopBar(title: S().broadcastTitle),
        body: ListView(
          padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 24.h),
          children: [
            Text(
              S().broadcastNote,
              style: TextStyle(
                fontSize: 12.5.sp,
                height: 1.8,
                color: context.colorScheme.onSurfaceVariant,
              ),
            ),
            SizedBox(height: 16.h),
            BlocBuilder<BarberBroadcastCubit, BarberBroadcastState>(
              builder: (context, state) => BarberBroadcastScopeSelector(
                scope: state.scope,
                onChanged: (scope) =>
                    context.read<BarberBroadcastCubit>().selectScope(scope),
              ),
            ),
            SizedBox(height: 16.h),
            SectionTitle(title: S().broadcastTitleFieldHint),
            AppTextField(
              controller: _titleController,
              hint: S().broadcastTitleFieldHint,
            ),
            SectionTitle(title: S().broadcastBodyFieldHint),
            AppTextField(
              controller: _bodyController,
              hint: S().broadcastBodyFieldHint,
              maxLines: 4,
            ),
            SizedBox(height: 20.h),
            BlocBuilder<BarberBroadcastCubit, BarberBroadcastState>(
              builder: (context, state) => PrimaryCtaButton(
                label: S().broadcastSendAction,
                isLoading: state.status == BarberBroadcastStatus.sending,
                onPressed: _submit,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
