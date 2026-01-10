import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants.dart';
import '../../../core/widgets/text_gradient.dart';
import '../../home/screens/home_screen.dart';
import '../../onboard/data/onboard_repository.dart';
import '../../onboard/screens/onboard_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds: 2),
      () {
        if (mounted) {
          if (context.read<OnboardRepository>().isOnboard()) {
            context.replace(OnboardScreen.routePath);
          } else {
            context.replace(HomeScreen.routePath);
          }
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
