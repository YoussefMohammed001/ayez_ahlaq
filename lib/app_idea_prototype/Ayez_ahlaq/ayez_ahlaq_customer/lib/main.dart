import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/splash_screen.dart';
import 'state/app_state.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const AyezAhlaqApp());
}

class AyezAhlaqApp extends StatelessWidget {
  const AyezAhlaqApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AppState(),
      child: MaterialApp(
        title: 'عايز أحلق',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.dark,
        // The whole app is Arabic-only for this prototype, so RTL is forced
        // here rather than wired through full localization support.
        builder: (context, child) => Directionality(
          textDirection: TextDirection.rtl,
          child: child!,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
