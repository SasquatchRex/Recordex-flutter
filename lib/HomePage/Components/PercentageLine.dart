import 'package:flutter/material.dart';


class PercentageLine extends StatelessWidget {
  final double percentage; // Percentage to fill (0 to 100)
  final Color backgroundColor;
  final Color fillColor;
  final double height;
  final double width;

  const PercentageLine(
      {Key? key,
        required this.percentage,
        this.backgroundColor = Colors.white60,
        this.fillColor = Colors.blue,
        this.height = 10.0,
        this.width = 40})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Clamp percentage between 0 and 100
    final clampedPercentage = percentage.clamp(0, 100);

    return Stack(
      children: [
        // Background Line
        Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(height / 2), // Rounded edges
          ),
        ),
        // Filled Line
        Container(
          height: height,
          width: width * (clampedPercentage / 100),
          decoration: BoxDecoration(
            color: fillColor,
            borderRadius: BorderRadius.circular(height / 2), // Rounded edges
          ),
        ),
      ],
    );
  }
}