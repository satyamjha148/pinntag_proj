import 'package:flutter/material.dart';

class CommonButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool isEnabled;
  final double borderRadius;
  final Color? backgroundColor;
  final Color? textColor;

  const CommonButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isEnabled = true,
    this.borderRadius = 16.0,
    this.backgroundColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final bgColor =
        backgroundColor ??
        (isEnabled
            ? colorScheme.primary
            // ignore: deprecated_member_use
            : theme.disabledColor.withOpacity(0.12));

    final fgColor =
        textColor ??
        (isEnabled
            ? colorScheme.onPrimary
            // ignore: deprecated_member_use
            : theme.disabledColor.withOpacity(0.6));

    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        onPressed: isEnabled ? onPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          foregroundColor: fgColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          elevation: 0,
          textStyle: theme.textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        child: Text(label),
      ),
    );
  }
}
