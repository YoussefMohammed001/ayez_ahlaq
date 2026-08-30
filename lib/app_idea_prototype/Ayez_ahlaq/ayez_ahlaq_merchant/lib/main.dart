import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/main_shell.dart';
import 'state/merchant_state.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const AyezAhlaqMerchantApp());
}

class AyezAhlaqMerchantApp extends StatelessWidget {
  const AyezAhlaqMerchantApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MerchantState(),
      child: MaterialApp(
        title: 'عايز أحلق - التاجر',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.dark,
        builder: (context, child) => Directionality(
          textDirection: TextDirection.rtl,
          child: child!,
        ),
        home: const MainShell(),
      ),
    );
  }
}
