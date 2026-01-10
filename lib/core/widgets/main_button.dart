import 'package:flutter/material.dart';

import '../constants.dart';
import 'button.dart';

class MainButton extends StatelessWidget {
  const MainButton({
    super.key,
    required this.title,
    this.gradient = const [
      Color(0xffFF6900),
      Color(0xffFE9A00),
    ],
    this.onPressed,
  });

  final String title;
  final List<Color> gradient;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final active = onPressed != null;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      height: 56,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: active
              ? gradient
              : [
                  gradient.first.withValues(alpha: 0.5),
                  gradient.last.withValues(alpha: 0.5),
                ],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 6,
            spreadRadius: -4,
            offset: const Offset(0, 4),
          ),
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 15,
            spreadRadius: -3,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Button(
        onPressed: onPressed,
        child: Center(
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontFamily: AppFonts.w500,
            ),
          ),
        ),
      ),
    );
  }
}
