import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/localization/l10n/app_localizations.dart';
import 'core/router.dart';
import 'features/lang/bloc/lang_bloc.dart';

class BreadApp extends StatelessWidget {
  const BreadApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LangBloc, Locale>(
      builder: (context, locale) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: locale,
          routerConfig: routerConfig,
          themeMode: ThemeMode.light,
          theme: ThemeData(
            scaffoldBackgroundColor: const Color(0xffF9FAFB),
            colorScheme: const ColorScheme.light(
              primary: Color(0xff101828),
              secondary: Color(0xfff54900), // overscroll
              surface: Color(0xffF9FAFB), // bg color when push
            ),
          ),
        );
      },
    );
  }
}
