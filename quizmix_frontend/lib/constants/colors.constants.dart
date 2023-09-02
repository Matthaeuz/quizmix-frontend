import 'dart:ui';
import 'dart:math' as math;

import 'package:flutter/material.dart';

Color getCategoryColor(String category) {
  switch (category) {
    case 'Basic Theories':
      return const Color(0xFFD4AF37);
    case 'Algorithms and Programming':
      return const Color(0xFF9854B2);
    case 'Computer Components and Hardware':
      return const Color(0xFFCF4321);
    case 'System Components':
      return const Color(0xFFC92D5C);
    case 'Software':
      return const Color(0xFF0D2916);
    case 'Development Technology and Management':
      return const Color(0xFF3371E4);
    case 'Database':
      return const Color(0xFF75A768);
    case 'Network':
      return const Color(0xFF8768A7);
    case 'Security':
      return const Color(0xFF223160);
    case 'System Audit, Strategy and Planning':
      return const Color(0xFF678026);
    case 'Business, Corporate & Legal Affairs':
      return const Color(0xFF282680);
    default:
      // Return a random color for unknown categories
      return Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
          .withOpacity(1.0);
  }
}

class AppColors {
  static const Color mainColor = Color(0xFF673AB7);
  static const Color secondaryColor = Color(0xFF6F61C0);
  static const Color thirdColor = Color(0xFFA084E8);
  static const Color fourthColor = Color(0xFF8BE8E5);
  static const Color fifthColor = Color(0xFF9C54D5);
  static const Color lightBackgroundColor = Color(0xFFF5F5F5);
  static const Color black = Color(0xFF333333);
  static const Color grey = Color(0xFF9E9E9E);
  static const Color white = Color(0xFFFFFFFF);
}
