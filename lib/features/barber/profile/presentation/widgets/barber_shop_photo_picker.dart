import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/helpers/alerts.dart';
import '../../../../../core/helpers/app_image_picker.dart';
import '../../../../../core/widgets/option_tile.dart';
import '../../../../../core/widgets/section_title.dart';
import '../../../../../generated/l10n.dart';
import '../manager/barber_profile_cubit.dart';

enum BarberShopPhotoAction { replace, remove }

class BarberShopPhotoPicker {
  BarberShopPhotoPicker._();

  static Future<void> pickAndUpload(BuildContext context) async {
    final file = await AppImagePicker.pickSingle();
    if (file == null || !context.mounted) return;

    final cubit = context.read<BarberProfileCubit>();

    await showLoading();
    final bool success;
    try {
      success = await cubit.uploadProfileImage(file.path);
    } finally {
      hideLoading();
    }

    if (!context.mounted) return;

    if (success) {
      showSuccess(S().shopPhotoUpdated);
    } else if (cubit.state.errorMessage != null) {
      showError(cubit.state.errorMessage!);
    }
  }

  static Future<BarberShopPhotoAction?> showEditSheet(BuildContext context) {
    return showModalBottomSheet<BarberShopPhotoAction>(
      context: context,
      builder: (_) => const _EditPhotoSheet(),
    );
  }
}

class _EditPhotoSheet extends StatelessWidget {
  const _EditPhotoSheet();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 24.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionTitle(title: S().shopPhotoEditTitle),
          OptionTile(
            label: S().shopPhotoReplace,
            icon: Icons.photo_camera_outlined,
            selected: false,
            onTap: () => Navigator.of(
              context,
            ).pop(BarberShopPhotoAction.replace),
          ),
          OptionTile(
            label: S().shopPhotoRemove,
            icon: Icons.delete_outline,
            selected: false,
            onTap: () => Navigator.of(
              context,
            ).pop(BarberShopPhotoAction.remove),
          ),
        ],
      ),
    );
  }
}
