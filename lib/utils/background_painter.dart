import 'package:flutter/material.dart';
import 'package:mhk_portfolio_flutter/utils/colors.dart';

class GridPatternPainter extends CustomPainter {
  final Color color;
  final bool isDarkMode;
  final double spacing;
  final double strokeWidth;

  GridPatternPainter({
    required this.color,
    required this.isDarkMode,
    this.spacing = 50.0,
    this.strokeWidth = 1.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth;

    // Draw vertical lines
    for (double x = 0; x < size.width; x += spacing) {
      canvas.drawLine(
        Offset(x, 0),
        Offset(x, size.height),
        paint,
      );
    }
    
    // Draw horizontal lines
    for (double y = 0; y < size.height; y += spacing) {
      canvas.drawLine(
        Offset(0, y),
        Offset(size.width, y),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class DotsPatternPainter extends CustomPainter {
  final Color color;
  final bool isDarkMode;
  final double spacing;
  final double dotSize;

  DotsPatternPainter({
    required this.color,
    required this.isDarkMode,
    this.spacing = 60.0,
    this.dotSize = 2.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    for (double x = 0; x < size.width; x += spacing) {
      for (double y = 0; y < size.height; y += spacing) {
        canvas.drawCircle(
          Offset(x, y),
          dotSize,
          paint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Utility widget for consistent background patterns
class BackgroundPattern extends StatelessWidget {
  final Widget child;
  final bool isDarkMode;
  final PatternType pattern;
  final double opacity;

  const BackgroundPattern({
    Key? key,
    required this.child,
    required this.isDarkMode,
    this.pattern = PatternType.grid,
    this.opacity = 0.05,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background gradient
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: isDarkMode
                  ? [Colors.black, Colors.grey[900]!, Colors.black]
                  : [Colors.white, Colors.grey[50]!, Colors.white],
            ),
          ),
        ),
        
        // Pattern overlay
        Positioned.fill(
          child: CustomPaint(
            painter: pattern == PatternType.grid
                ? GridPatternPainter(
                    color: AppColors.gold.withOpacity(opacity),
                    isDarkMode: isDarkMode,
                  )
                : DotsPatternPainter(
                    color: AppColors.gold.withOpacity(opacity),
                    isDarkMode: isDarkMode,
                  ),
          ),
        ),
        
        // Content
        child,
      ],
    );
  }
}

enum PatternType { grid, dots }