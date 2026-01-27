import 'package:flutter/material.dart';

class CustomCircularProgress extends StatelessWidget {
  final double size;
  final double strokeWidth;
  final Color? color;
  final Color? backgroundColor;
  final bool showPercentage;

  const CustomCircularProgress({
    super.key,
    this.size = 44,
    this.strokeWidth = 3,
    this.color,
    this.backgroundColor,
    this.showPercentage = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: CircularProgressIndicator(
        strokeWidth: strokeWidth,
        strokeCap: StrokeCap.round,
        color: Colors.black,
        backgroundColor:
            backgroundColor ?? theme.colorScheme.onSurface.withOpacity(0.08),
      ),
    );
  }
}
