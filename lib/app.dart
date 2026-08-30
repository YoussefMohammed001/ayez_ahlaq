import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart'
    show
        GlobalWidgetsLocalizations,
        GlobalCupertinoLocalizations,
        GlobalMaterialLocalizations;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/app_cubit/app_cubit.dart';
import 'core/app_cubit/app_state.dart';
import 'core/cache/preferences_storage/preferences_storage.dart';
import 'core/di/services_locator.dart';
import 'core/routes/app_routes.dart';
import 'core/session/session_events.dart';
import 'core/session/session_manager.dart';
import 'core/theme/dark_theme.dart';
import 'core/theme/light_theme.dart';
import 'core/widgets/offline_banner.dart';
import 'generated/l10n.dart';

class AyezAhlaqApp extends StatefulWidget {
  const AyezAhlaqApp({super.key});

  @override
  State<AyezAhlaqApp> createState() => _AyezAhlaqAppState();
}

class _AyezAhlaqAppState extends State<AyezAhlaqApp> {
  StreamSubscription<String>? _sessionSub;

  @override
  void initState() {
    super.initState();

    final sessionManager = sl<SessionManager>();

    _sessionSub = sessionManager.sessionEvents.listen((event) {
      if (event == SessionEvents.unauthorized) {
        sessionManager.handleUnauthorized();
      }
    });
  }

  @override
  void dispose() {
    _sessionSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(402, 874),
      minTextAdapt: true,
      splitScreenMode: true,
      useInheritedMediaQuery: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: _providers,
          child: BlocBuilder<AppCubit, AppState>(
            builder: (context, state) {
              final cubit = context.read<AppCubit>();

              final textDirection =
                  sl<PreferencesStorage>().getCurrentLanguage() == "en"
                  ? TextDirection.ltr
                  : TextDirection.rtl;

              return Directionality(
                textDirection: textDirection,
                child: MaterialApp.router(
                  key: ValueKey(sl<PreferencesStorage>().getCurrentLanguage()),
                  title: 'ayez_ahlaq',
                  routerConfig: routes,
                  debugShowCheckedModeBanner: false,
                  themeMode: cubit.themeMode,
                  darkTheme: darkTheme,
                  theme: lightTheme,
                  locale: Locale(sl<PreferencesStorage>().getCurrentLanguage()),
                  supportedLocales: S.delegate.supportedLocales,
                  localizationsDelegates: const [
                    S.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                  ],
                  builder: (context, child) => Stack(
                    children: [
                      if (child != null) child,
                      const Align(
                        alignment: Alignment.topCenter,
                        child: OfflineBanner(),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  final _providers = [
    BlocProvider<AppCubit>(create: (context) => AppCubit()..checkConnection()),
  ];
}
