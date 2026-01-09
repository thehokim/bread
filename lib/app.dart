import 'package:flutter/material.dart';

import 'core/router.dart';

class BreadApp extends StatelessWidget {
  const BreadApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
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
  }
}
