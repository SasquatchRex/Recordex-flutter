import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Provider/main_provider.dart';
import '../topside.dart';
import 'dart:math';
import 'package:fl_chart/fl_chart.dart';



class HalfCircleProgress extends StatelessWidget {
  final double percentage; // Percentage to fill (0 to 100)
  final Color backgroundColor;
  final Color progressColor;
  final double strokeWidth;
  final double size;

  const HalfCircleProgress({
    Key? key,
    required this.percentage,
    this.backgroundColor = Colors.grey,
    this.progressColor = Colors.blue,
    this.strokeWidth = 10.0,
    this.size = 200.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final clampedPercentage = percentage.clamp(0, 100);
    return SizedBox(
      height: size,
      width: size,
      child: CustomPaint(
        painter: _HalfCirclePainter(
          percentage: percentage,
          backgroundColor: backgroundColor,
          progressColor: progressColor,
          strokeWidth: strokeWidth,
        ),
        child: Center(
          child: Text(
            "${percentage.toInt()}%",
            style: TextStyle(
              color: Provider.of<AppColors>(context).appColors.primaryText,
              fontSize: size * 0.2, // Scale font size based on size
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}

class _HalfCirclePainter extends CustomPainter {
  final double percentage;
  final Color backgroundColor;
  final Color progressColor;
  final double strokeWidth;

  _HalfCirclePainter({
    required this.percentage,
    required this.backgroundColor,
    required this.progressColor,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);

    // Draw the background arc
    final backgroundPaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      rect,
      pi * 3 / 4, // Start from left
      pi, // Half-circle (pi radians)
      false,
      backgroundPaint,
    );

    // Draw the progress arc
    final progressPaint = Paint()
      ..color = progressColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final sweepAngle = (percentage / 100) * pi; // Calculate progress angle
    canvas.drawArc(
      rect,
      pi * 3 / 4, // Start from left
      sweepAngle, // Progress arc
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}