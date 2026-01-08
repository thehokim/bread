import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'auth/providers/auth_provider.dart';
import 'features/onboarding/screens/onboarding_screen.dart';
import 'features/home/screens/main_screen.dart';
import 'auth/screens/phone_input_screen.dart';

class BreadApp extends StatelessWidget {
  const BreadApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'doim.uz',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFFFF8C00),
        scaffoldBackgroundColor: const Color(0xFFFFF8F0),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFFF8C00),
          primary: const Color(0xFFFF8C00),
        ),
        textTheme: GoogleFonts.interTextTheme(),
        useMaterial3: true,
      ),
      home: Consumer<AuthProvider>(
        builder: (context, auth, _) {
          if (!auth.hasSeenOnboarding) {
            return const OnboardingScreen();
          }
          
          if (!auth.isAuthenticated) {
            return const PhoneInputScreen();
          }
          
          return const MainScreen();
        },
      ),
    );
  }
}