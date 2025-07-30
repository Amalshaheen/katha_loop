import 'package:flutter/material.dart';

class ResponsiveBreakpoints {
  static const double mobile = 600;
  static const double tablet = 1024;
  static const double desktop = 1440;
}

class AppSpacing {
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 16.0;
  static const double lg = 24.0;
  static const double xl = 32.0;
  static const double xxl = 48.0;
}

class AppRadius {
  static const double sm = 8.0;
  static const double md = 12.0;
  static const double lg = 16.0;
  static const double xl = 24.0;
  static const double xxl = 32.0;
}

extension ResponsiveExtension on BuildContext {
  bool get isMobile => MediaQuery.of(this).size.width < ResponsiveBreakpoints.mobile;
  bool get isTablet => MediaQuery.of(this).size.width >= ResponsiveBreakpoints.mobile && 
                      MediaQuery.of(this).size.width < ResponsiveBreakpoints.tablet;
  bool get isDesktop => MediaQuery.of(this).size.width >= ResponsiveBreakpoints.tablet;
  
  double get screenWidth => MediaQuery.of(this).size.width;
  double get screenHeight => MediaQuery.of(this).size.height;
  
  EdgeInsets get safeAreaPadding => MediaQuery.of(this).padding;
  EdgeInsets get viewInsets => MediaQuery.of(this).viewInsets;
}

class AccessibilityHelper {
  static Widget makeAccessible({
    required Widget child,
    required String semanticLabel,
    String? hint,
    bool excludeSemantics = false,
  }) {
    return Semantics(
      label: semanticLabel,
      hint: hint,
      excludeSemantics: excludeSemantics,
      child: child,
    );
  }

  static Widget makeFocusable({
    required Widget child,
    required VoidCallback onTap,
    String? semanticLabel,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Semantics(
        button: true,
        label: semanticLabel,
        child: child,
      ),
    );
  }
}