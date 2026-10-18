import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../extensions/ext_theme.dart';
import 'app_input_decoration.dart';

class AppSearchField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final Duration debounce;

  const AppSearchField({
    super.key,
    required this.controller,
    required this.hintText,
    this.onChanged,
    this.onSubmitted,
    this.debounce = const Duration(milliseconds: 400),
  });

  @override
  State<AppSearchField> createState() => _AppSearchFieldState();
}

class _AppSearchFieldState extends State<AppSearchField> {
  Timer? _debounceTimer;

  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }

  void _handleChanged(String value) {
    _debounceTimer?.cancel();
    if (value.isEmpty) {
      widget.onChanged?.call(value);
      return;
    }
    _debounceTimer = Timer(
      widget.debounce,
      () => widget.onChanged?.call(value),
    );
  }

  void _handleClear() {
    _debounceTimer?.cancel();
    widget.controller.clear();
    widget.onChanged?.call('');
  }

  @override
  Widget build(BuildContext context) {
    final scheme = context.colorScheme;

    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: widget.controller,
      builder: (context, value, _) {
        return TextField(
          controller: widget.controller,
          onChanged: _handleChanged,
          onSubmitted: widget.onSubmitted,
          textInputAction: TextInputAction.search,
          onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
          style: TextStyle(fontSize: 13.5.sp, color: scheme.onSurface),
          decoration: AppInputDecoration.build(context, widget.hintText)
              .copyWith(
                hintStyle: TextStyle(
                  fontSize: 13.5.sp,
                  color: scheme.onSurfaceVariant,
                ),
                prefixIcon: Icon(
                  Icons.search_rounded,
                  size: 20.r,
                  color: scheme.onSurfaceVariant,
                ),
                suffixIcon: value.text.isEmpty
                    ? null
                    : IconButton(
                        icon: Icon(
                          Icons.close_rounded,
                          size: 18.r,
                          color: scheme.onSurfaceVariant,
                        ),
                        onPressed: _handleClear,
                      ),
                contentPadding: EdgeInsets.symmetric(vertical: 12.h),
              ),
        );
      },
    );
  }
}
