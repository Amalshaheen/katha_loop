import 'dart:ui';
import 'package:flutter/material.dart';

class AppColorScheme {
  // Material Design 3 inspired color palette
  static const Color primaryLight = Color(0xFF6750A4);
  static const Color primaryDark = Color(0xFFD0BCFF);
  static const Color secondaryLight = Color(0xFF625B71);
  static const Color secondaryDark = Color(0xFFCCC2DC);
  static const Color tertiaryLight = Color(0xFF7D5260);
  static const Color tertiaryDark = Color(0xFFEFB8C8);
  static const Color surfaceLight = Color(0xFFFEF7FF);
  static const Color surfaceDark = Color(0xFF141218);
  static const Color backgroundLight = Color(0xFFFEF7FF);
  static const Color backgroundDark = Color(0xFF141218);
  static const Color errorLight = Color(0xFFBA1A1A);
  static const Color errorDark = Color(0xFFFFB4AB);
  
  // Chat bubble colors - softer, more accessible
  static const List<Color> chatBubbleColors = [
    Color(0xFFE8F5E8), // Light green
    Color(0xFFE3F2FD), // Light blue
    Color(0xFFF3E5F5), // Light purple
    Color(0xFFFFF8E1), // Light yellow
    Color(0xFFFFEBEE), // Light pink
  ];
  
  // Legacy colors for backward compatibility
  @Deprecated('Use AppColorScheme.primaryLight instead')
  static const background = Color(0xffffad60);
  @Deprecated('Use AppColorScheme.primaryLight instead')
  static const primary = Color.fromARGB(255, 4, 34, 80);
  @Deprecated('Use AppColorScheme.secondaryLight instead')
  static const secondary = Color(0xffFFEEAD);
  @Deprecated('Use AppColorScheme.chatBubbleColors instead')
  static const blue = Color(0xff96CEB4);
  @Deprecated('Use AppColorScheme.chatBubbleColors instead')
  static const orange = Color(0xfffa984c);
  @Deprecated('Use AppColorScheme.chatBubbleColors instead')
  static const grey = Color(0xffa6b4ce);
  @Deprecated('Use AppColorScheme.chatBubbleColors instead')
  static const grape = Color(0xffb7a8b1);
  @Deprecated('Use AppColorScheme.chatBubbleColors instead')
  static const yellow = Color(0xfffbc62);
}

// Legacy support
class ColorSchemeNew {
  static const background = AppColorScheme.background;
  static const primary = AppColorScheme.primary;
  static const secondary = AppColorScheme.secondary;
  static const blue = AppColorScheme.blue;
  static const orange = AppColorScheme.orange;
  static const grey = AppColorScheme.grey;
  static const grape = AppColorScheme.grape;
  static const yellow = AppColorScheme.yellow;
}

final chatColors = AppColorScheme.chatBubbleColors;
