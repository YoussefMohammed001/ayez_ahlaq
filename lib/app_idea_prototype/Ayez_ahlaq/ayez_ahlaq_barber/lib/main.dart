import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/main_shell.dart';
import 'state/barber_state.dart';
import 'theme/app_colors.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const AyezAhlaqBarberApp());
}

class AyezAhlaqBarberApp extends StatelessWidget {
  const AyezAhlaqBarberApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => BarberState(),
      child: MaterialApp(
        title: 'لوحة الحلاق',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.dark,
        // Forces RTL (no flutter_localizations wiring for this prototype)
        // and, on a wide desktop window, keeps the phone-width layout as a
        // centered column instead of stretching it edge to edge — same
        // widget tree runs unchanged on Android/iOS/Windows/macOS/Linux.
        builder: (context, child) => Directionality(
          textDirection: TextDirection.rtl,
          child: ColoredBox(
            color: AppColors.ink950,
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 520),
                child: child,
              ),
            ),
          ),
        ),
        home: const MainShell(),
      ),
    );
  }
}
