import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:ayez_ahlaq/core/cache/preferences_storage/preferences_storage.dart';

import 'package:ayez_ahlaq/core/cache/preferences_storage/preferences_storage_keys.dart';
import 'package:ayez_ahlaq/core/di/services_locator.dart';
import 'package:ayez_ahlaq/core/routes/route_paths.dart';

class DebugSwitcherDialog extends StatefulWidget {
  const DebugSwitcherDialog({super.key});

  @override
  State<DebugSwitcherDialog> createState() => _DebugSwitcherDialogState();
}

class _DebugSwitcherDialogState extends State<DebugSwitcherDialog> {
  late bool _isDebugEnabled;
  late PreferencesStorage storage;

  final TextEditingController _passwordController = TextEditingController();
  String? _errorText;

  static const String _debugPassword = "ayez_ahlaq@Debugger";

  @override
  void initState() {
    super.initState();
    storage = sl<PreferencesStorage>();
    _isDebugEnabled = storage.getBoolean(
      key: PreferencesKeys.isDebugEnabled,
      defaultValue: false,
    );
  }

  Future<void> _apply() async {
    if (_isDebugEnabled) {
      if (_passwordController.text != _debugPassword) {
        setState(() {
          _errorText = "Wrong password";
        });
        return;
      }
    }

    await storage.putBoolean(
      key: PreferencesKeys.isDebugEnabled,
      value: _isDebugEnabled,
    );

    await sl.reset();
    await ServicesLocator().init();

    if (mounted) {
      context.go(Routes.splashScreen);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      title: const Text('Debug Settings'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Enable Debug Tools'),
              Switch(
                value: _isDebugEnabled,
                onChanged: (value) {
                  setState(() {
                    _isDebugEnabled = value;
                    _errorText = null;
                  });
                },
              ),
            ],
          ),

          if (_isDebugEnabled) ...[
            SizedBox(height: 12.h),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Enter Password",
                errorText: _errorText,
                border: const OutlineInputBorder(),
              ),
            ),
          ],
        ],
      ),
      actions: [
        TextButton(onPressed: () => context.pop(), child: const Text('Cancel')),
        FilledButton(onPressed: _apply, child: const Text('Apply')),
      ],
    );
  }
}
