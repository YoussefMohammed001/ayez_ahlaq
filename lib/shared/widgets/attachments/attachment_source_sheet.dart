import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/widgets/option_tile.dart';
import '../../../core/widgets/section_title.dart';
import '../../../generated/l10n.dart';
import 'attachment_source.dart';

class AttachmentSourceSheet extends StatelessWidget {
  final bool allowFiles;

  const AttachmentSourceSheet({super.key, this.allowFiles = true});

  static Future<AttachmentSource?> show(
    BuildContext context, {
    bool allowFiles = true,
  }) {
    return showModalBottomSheet<AttachmentSource>(
      context: context,
      builder: (_) => AttachmentSourceSheet(allowFiles: allowFiles),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 24.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionTitle(title: S().chooseUploadSource),
          OptionTile(
            label: S().camera,
            icon: Icons.photo_camera_outlined,
            selected: false,
            onTap: () => Navigator.of(context).pop(AttachmentSource.camera),
          ),
          OptionTile(
            label: S().gallery,
            icon: Icons.photo_library_outlined,
            selected: false,
            onTap: () => Navigator.of(context).pop(AttachmentSource.gallery),
          ),
          if (allowFiles)
            OptionTile(
              label: S().filesSource,
              icon: Icons.folder_outlined,
              selected: false,
              onTap: () => Navigator.of(context).pop(AttachmentSource.files),
            ),
        ],
      ),
    );
  }
}
