import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/helpers/alerts.dart';
import '../../../../../core/routes/route_paths.dart';
import '../../../../../core/widgets/app_card.dart';
import '../../../../../core/widgets/app_error_state.dart';
import '../../../../../core/widgets/app_top_bar.dart';
import '../../../../../core/widgets/avatar_circle.dart';
import '../../../../../core/widgets/list_skeleton.dart';
import '../../../../../core/widgets/primary_cta_button.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../generated/l10n.dart';
import '../manager/invite_preview_cubit.dart';
import '../manager/invite_preview_state.dart';

class InvitePreviewScreen extends StatefulWidget {
  final String inviteCode;

  const InvitePreviewScreen({super.key, required this.inviteCode});

  @override
  State<InvitePreviewScreen> createState() => _InvitePreviewScreenState();
}

class _InvitePreviewScreenState extends State<InvitePreviewScreen> {
  @override
  void initState() {
    super.initState();
    context.read<InvitePreviewCubit>().loadPreview(widget.inviteCode);
  }

  Future<void> _addToFavorites(BuildContext context) async {
    final cubit = context.read<InvitePreviewCubit>();

    if (!await cubit.isLoggedIn()) {
      if (!context.mounted) return;
      context.push(Routes.customerLoginScreen);
      return;
    }

    await cubit.addViaInvite(widget.inviteCode);

    if (!context.mounted) return;

    if (cubit.state.status == InvitePreviewStatus.added) {
      showSuccess(S().addedToFavorites);
      context.go(Routes.customerFavoritesScreen);
    } else if (cubit.state.errorMessage != null) {
      showError(cubit.state.errorMessage!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppTopBar(title: S().inviteePreviewTitle),
      body: BlocBuilder<InvitePreviewCubit, InvitePreviewState>(
        builder: (context, state) {
          final cubit = context.read<InvitePreviewCubit>();

          if (state.status == InvitePreviewStatus.loading && state.preview == null) {
            return const ListSkeleton();
          }

          final preview = state.preview;
          if (state.status == InvitePreviewStatus.failure && preview == null) {
            return AppErrorState(
              message: state.errorMessage,
              onRetry: () => cubit.loadPreview(widget.inviteCode),
            );
          }

          if (preview == null) return const SizedBox.shrink();

          return ListView(
            padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 24.h),
            children: [
              AppCard(
                child: Column(
                  children: [
                    AvatarCircle(
                      initials: preview.barberName.isEmpty
                          ? S().avatarFallback
                          : preview.barberName.substring(0, 1),
                      size: 64.r,
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      preview.barberName,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w800,
                        color: context.colorScheme.onSurface,
                      ),
                    ),
                    if ((preview.tagline ?? '').isNotEmpty) ...[
                      SizedBox(height: 4.h),
                      Text(
                        preview.tagline!,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 12.5.sp, color: context.colorScheme.onSurfaceVariant),
                      ),
                    ],
                    SizedBox(height: 10.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.star_rounded, size: 16.r, color: context.semantic.accentSoft),
                        SizedBox(width: 4.w),
                        Text(
                          '${preview.rating.toStringAsFixed(1)} (${preview.ratingCount})',
                          style: TextStyle(fontSize: 12.5.sp, color: context.colorScheme.onSurfaceVariant),
                        ),
                      ],
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      preview.shopName,
                      style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w600, color: context.colorScheme.onSurface),
                    ),
                    if ((preview.address ?? preview.area ?? '').isNotEmpty)
                      Text(
                        preview.address ?? preview.area!,
                        style: TextStyle(fontSize: 11.5.sp, color: context.colorScheme.onSurfaceVariant),
                      ),
                  ],
                ),
              ),
              SizedBox(height: 24.h),
              PrimaryCtaButton(
                label: S().addToFavorites,
                isLoading: state.status == InvitePreviewStatus.adding,
                onPressed: () => _addToFavorites(context),
              ),
            ],
          );
        },
      ),
    );
  }
}
