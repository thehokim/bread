import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants.dart';
import '../../home/screens/home_screen.dart';
import '../../onboarding/data/onboard_repository.dart';
import '../../onboarding/screens/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void replace() {
    if (context.read<OnboardRepository>().isOnboard()) {
      context.replace(OnboardingScreen.routePath);
    } else {
      context.replace(HomeScreen.routePath);
    }
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds: 2),
      () {
        if (mounted) {
          replace();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: SizedBox(
              width: 106,
              height: 106,
              child: Stack(
                children: [
                  RotationTransition(
                    turns: const AlwaysStoppedAnimation(6 / 360),
                    child: Container(
                      height: 106,
                      width: 105,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        gradient: const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color(0xffFF6900),
                            Color(0xffFE9A00),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const Center(
                    child: Text(
                      '🍞',
                      style: TextStyle(
                        fontSize: 48,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          const GradientText(
            'doim.uz',
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Color(0xffF54900),
                Color(0xffE17100),
              ],
            ),
            style: TextStyle(
              fontSize: 36,
              fontFamily: AppFonts.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class GradientText extends StatelessWidget {
  const GradientText(
    this.text, {
    super.key,
    required this.gradient,
    this.style,
  });

  final String text;
  final TextStyle? style;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(text, style: style),
    );
  }
}
