// Add this to a new file: `lib/components/animated_owl.dart`
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class AnimatedOwl extends StatelessWidget {
  final String animationType; // 'welcome', 'celebrate', 'sad'
  final double size;

  const AnimatedOwl({
    super.key,
    required this.animationType,
    this.size = 150,
  });

  @override
  Widget build(BuildContext context) {
    String animationFile;
    switch (animationType) {
      case 'celebrate':
        animationFile = 'assets/animations/owl_celebrate.json';
        break;
      case 'sad':
        animationFile = 'assets/animations/owl_sad.json';
        break;
      default:
        animationFile = 'assets/animations/owl_wave.json';
    }

    return Lottie.asset(
      animationFile,
      width: size,
      height: size,
      repeat: animationType == 'welcome', // Only loop for welcome
    );
  }
}