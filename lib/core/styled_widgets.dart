import 'package:flutter/material.dart';

class StyledIcon extends StatelessWidget {
  const StyledIcon(
    this.iconData, {
    super.key,
    this.size,
    this.color,
  });
  
  final IconData iconData;
  final double? size;
  final Color? color;
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Icon(
      iconData,
      size: size ?? 24,
      color: color ?? theme.colorScheme.primary,
    );
  }
}

class StyledButton extends StatelessWidget {
  const StyledButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.variant = ButtonVariant.filled,
    this.size = ButtonSize.medium,
  });

  final VoidCallback? onPressed;
  final Widget child;
  final ButtonVariant variant;
  final ButtonSize size;

  @override
  Widget build(BuildContext context) {
    final padding = switch (size) {
      ButtonSize.small => const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ButtonSize.medium => const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      ButtonSize.large => const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
    };

    return switch (variant) {
      ButtonVariant.filled => FilledButton(
          onPressed: onPressed,
          style: FilledButton.styleFrom(padding: padding),
          child: child,
        ),
      ButtonVariant.outlined => OutlinedButton(
          onPressed: onPressed,
          style: OutlinedButton.styleFrom(padding: padding),
          child: child,
        ),
      ButtonVariant.text => TextButton(
          onPressed: onPressed,
          style: TextButton.styleFrom(padding: padding),
          child: child,
        ),
    };
  }
}

enum ButtonVariant { filled, outlined, text }
enum ButtonSize { small, medium, large }

class StyledCard extends StatelessWidget {
  const StyledCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.elevation,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? elevation;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: elevation,
      margin: margin,
      child: Padding(
        padding: padding ?? const EdgeInsets.all(16),
        child: child,
      ),
    );
  }
}
