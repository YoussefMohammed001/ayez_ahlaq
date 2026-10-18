import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/extensions/ext_theme.dart';
import '../../../../../core/helpers/alerts.dart';
import '../../../../../core/helpers/show_confirm_dialog.dart';
import '../../../../../core/widgets/avatar_circle.dart';
import '../../../../../generated/l10n.dart';
import '../manager/barber_profile_cubit.dart';
import '../manager/barber_profile_state.dart';
import 'barber_shop_photo_picker.dart';

class BarberShopPhotoAvatar extends StatelessWidget {
  final String initials;
  final bool canEdit;
  final double size;

  const BarberShopPhotoAvatar({
    super.key,
    required this.initials,
    required this.canEdit,
    this.size = 84,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BarberProfileCubit, BarberProfileState>(
      buildWhen: (previous, current) =>
          previous.imageStatus != current.imageStatus ||
          previous.profileImageBytes != current.profileImageBytes,
      builder: (context, state) {
        return GestureDetector(
          onTap: canEdit ? () => _onTap(context, state) : null,
          child: Stack(
            alignment: Alignment.center,
            children: [
              _buildAvatar(context, state),
              if (_isBusy(state))
                SizedBox(
                  width: size.r,
                  height: size.r,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: state.imageStatus == ProfileImageStatus.loading
                        ? context.colorScheme.primary
                        : context.colorScheme.surfaceContainerLowest,
                  ),
                ),
              if (canEdit && !_isBusy(state))
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: _buildEditBadge(context),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAvatar(BuildContext context, BarberProfileState state) {
    final bytes = state.profileImageBytes;
    if (state.imageStatus == ProfileImageStatus.loaded && bytes != null) {
      return ClipOval(
        child: Image.memory(
          bytes,
          width: size.r,
          height: size.r,
          fit: BoxFit.cover,
        ),
      );
    }

    return AvatarCircle(initials: initials, size: size.r);
  }

  bool _isBusy(BarberProfileState state) =>
      state.imageStatus == ProfileImageStatus.loading ||
      state.imageStatus == ProfileImageStatus.submitting;

  Widget _buildEditBadge(BuildContext context) {
    return Container(
      width: 26.r,
      height: 26.r,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: context.colorScheme.primary,
        shape: BoxShape.circle,
        border: Border.all(
          color: context.colorScheme.surface,
          width: 2.r,
        ),
      ),
      child: Icon(
        Icons.camera_alt_rounded,
        size: 13.r,
        color: context.colorScheme.surfaceContainerLowest,
      ),
    );
  }

  Future<void> _onTap(BuildContext context, BarberProfileState state) async {
    final hasImage =
        state.imageStatus == ProfileImageStatus.loaded &&
        state.profileImageBytes != null;

    if (!hasImage) {
      await BarberShopPhotoPicker.pickAndUpload(context);
      return;
    }

    final action = await BarberShopPhotoPicker.showEditSheet(context);
    if (action == null || !context.mounted) return;

    if (action == BarberShopPhotoAction.replace) {
      await BarberShopPhotoPicker.pickAndUpload(context);
    } else if (action == BarberShopPhotoAction.remove) {
      await _confirmDelete(context);
    }
  }

  Future<void> _confirmDelete(BuildContext context) async {
    final confirmed = await showConfirmDialog(
      context,
      title: S().shopPhotoDeleteTitle,
      message: S().shopPhotoDeleteMessage,
    );

    if (!confirmed || !context.mounted) return;

    final cubit = context.read<BarberProfileCubit>();

    await showLoading();
    final bool success;
    try {
      success = await cubit.deleteProfileImage();
    } finally {
      hideLoading();
    }

    if (!context.mounted) return;

    if (success) {
      showSuccess(S().shopPhotoDeleted);
    } else if (cubit.state.errorMessage != null) {
      showError(cubit.state.errorMessage!);
    }
  }
}
