import 'package:flutter/material.dart';

class CustomOutlinedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Widget? prefix;
  final EdgeInsets padding;
  final double borderRadius;

  const CustomOutlinedButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.prefix,
    this.padding = const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
    this.borderRadius = 6,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(borderRadius),
      onTap: onPressed,
      child: Container(
        padding: padding,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(color: Colors.grey.shade400, width: 0.8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (prefix != null) ...[prefix!, const SizedBox(width: 8)],
            Text(
              text,
              style: TextStyle(
                color: Colors.grey.shade700,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
