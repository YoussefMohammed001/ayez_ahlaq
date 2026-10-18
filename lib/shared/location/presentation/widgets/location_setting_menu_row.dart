import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/extensions/ext_theme.dart';
import '../../../../core/widgets/menu_row.dart';
import '../../../../generated/l10n.dart';
import '../manager/location_status_cubit.dart';
import '../manager/location_status_state.dart';

class LocationSettingMenuRow {
  static MenuRow build(BuildContext context, LocationStatusState status) {
    final isOn = status.availability.isAvailable;

    return MenuRow(
      icon: isOn ? Icons.location_on_outlined : Icons.location_off_outlined,
      label: S().locationSettingLabel,
      onTap: isOn ? null : context.read<LocationStatusCubit>().enable,
      showChevron: !isOn,
      trailing: Text(
        isOn ? S().locationSettingOn : S().locationSettingOff,
        style: TextStyle(
          fontSize: 13.sp,
          color: isOn
              ? context.semantic.accentStrong
              : context.semantic.warning,
        ),
      ),
    );
  }
}
