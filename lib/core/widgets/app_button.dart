import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String title;
  final IconData? icon;
  final VoidCallback onPressed;
  final bool outlined;
  final Color? backgroundColor;
  final Color? foregroundColor;

  const AppButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.icon,
    this.outlined = false,
    this.backgroundColor,
    this.foregroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      height: 52,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: outlined ? 0 : 4,
          backgroundColor: outlined
              ? Colors.transparent
              : backgroundColor ?? theme.colorScheme.primary,
          foregroundColor:
              foregroundColor ??
              (outlined ? theme.colorScheme.primary : Colors.white),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
            side: outlined
                ? BorderSide(color: theme.colorScheme.primary)
                : BorderSide.none,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 20),
              const SizedBox(width: 10),
            ],
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
