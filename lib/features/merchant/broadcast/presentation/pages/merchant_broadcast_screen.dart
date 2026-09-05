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
import '../../../profile/domain/entities/merchant_profile.dart';
import '../manager/merchant_broadcast_cubit.dart';
import '../manager/merchant_broadcast_state.dart';
import '../widgets/broadcast_scope_selector.dart';

class MerchantBroadcastScreen extends StatefulWidget {
  final MerchantProfile? profile;

  const MerchantBroadcastScreen({super.key, this.profile});

  @override
  State<MerchantBroadcastScreen> createState() =>
      _MerchantBroadcastScreenState();
}

class _MerchantBroadcastScreenState extends State<MerchantBroadcastScreen> {
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

    final cubit = context.read<MerchantBroadcastCubit>();
    final sent = await cubit.send(title: title, body: body);

    if (!mounted) return;

    if (sent) {
      showSuccess(S().broadcastSentSuccess);
      context.pop();
      return;
    }

    showError(cubit.state.errorMessage ?? S().somethingWentWrong);
  }

  @override
  Widget build(BuildContext context) {
    final hasZone = widget.profile?.zoneName != null;

    return Scaffold(
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
          BlocBuilder<MerchantBroadcastCubit, MerchantBroadcastState>(
            builder: (context, state) => BroadcastScopeSelector(
              scope: state.scope,
              zoneName: widget.profile?.zoneName,
              onChanged: hasZone
                  ? (scope) =>
                        context.read<MerchantBroadcastCubit>().selectScope(scope)
                  : null,
            ),
          ),
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
          BlocBuilder<MerchantBroadcastCubit, MerchantBroadcastState>(
            builder: (context, state) => PrimaryCtaButton(
              label: S().broadcastSendAction,
              isLoading: state.status == MerchantBroadcastStatus.sending,
              onPressed: _submit,
            ),
          ),
        ],
      ),
    );
  }
}
