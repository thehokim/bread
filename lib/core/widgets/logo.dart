import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({super.key, required this.size});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xffFF6900),
            Color(0xffFE9A00),
          ],
        ),
      ),
      child: Center(
        child: Text(
          '🍞',
          style: TextStyle(fontSize: size / 2),
        ),
      ),
    );
  }
}
