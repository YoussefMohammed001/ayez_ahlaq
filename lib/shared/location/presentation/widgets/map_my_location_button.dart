import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/extensions/ext_theme.dart';
import '../manager/map_location_picker_cubit.dart';
import '../manager/map_location_picker_state.dart';

class MapMyLocationButton extends StatelessWidget {
  final VoidCallback onPressed;

  const MapMyLocationButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final scheme = context.colorScheme;
    final accent = context.semantic.accentStrong;

    return BlocSelector<MapLocationPickerCubit, MapLocationPickerState, bool>(
      selector: (state) => state.isLocating,
      builder: (_, isLocating) => Material(
        color: scheme.surface,
        elevation: 2,
        shape: const CircleBorder(),
        child: InkWell(
          customBorder: const CircleBorder(),
          onTap: isLocating ? null : onPressed,
          child: SizedBox(
            width: 46.r,
            height: 46.r,
            child: isLocating
                ? Padding(
                    padding: EdgeInsets.all(13.r),
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: accent,
                    ),
                  )
                : Icon(Icons.my_location_rounded, size: 24.r, color: accent),
          ),
        ),
      ),
    );
  }
}
