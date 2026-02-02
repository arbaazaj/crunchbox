import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../../core/themes/colors.dart';

class AnimatedBackgroundGradient extends StatelessWidget {
  const AnimatedBackgroundGradient({super.key, required this.context});

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Positioned.fill(
      child: ClipRect(
        child: Stack(
          children: [
            Positioned(
              top: -size.height * 0.1,
              left: -size.width * 0.2,
              child: Container(
                height: size.width * 0.8,
                width: size.width * 0.8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primary.withValues(alpha: 0.3),
                ),
              ),
            ),
            Positioned(
              bottom: -size.height * 0.2,
              right: -size.width * 0.3,
              child: Container(
                height: size.width,
                width: size.width,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.deepPurple.withValues(alpha: 0.2),
                ),
              ),
            ),
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 100.0, sigmaY: 100.0),
              child: Container(color: Colors.black.withValues(alpha: 0.1)),
            ),
          ],
        ),
      ),
    );
  }
}
