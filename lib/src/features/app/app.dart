// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:talker_flutter/talker_flutter.dart';

import 'package:tudushka/src/router/router.dart';
import 'package:tudushka/src/services/get_it.dart';
import 'package:tudushka/src/theme/app_theme.dart';

class TudushkaApp extends StatefulWidget {
  const TudushkaApp({super.key});

  @override
  State<TudushkaApp> createState() => _TudushkaAppState();
}

class _TudushkaAppState extends State<TudushkaApp> {
  late final GoRouter _router = createRouter();

  @override
  void initState() {
    _router.routerDelegate.addListener(() {
      getIt<Talker>().logTyped(
          TalkerLog(
            _router.routerDelegate.currentConfiguration.last.matchedLocation,
            title: WellKnownTitles.route.title,
            pen: AnsiPen()..rgb(r: 0.5, g: 0.5, b: 1.0),
            logLevel: LogLevel.info,
          ),
          logLevel: LogLevel.info);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Tudushka',
      theme: LightTheme,
      locale: const Locale("ru", "RU"),
      supportedLocales: const [
        Locale("ru", "RU"),
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      routerConfig: _router,
    );
  }
}
