import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Provider/main_provider.dart';
import '../topside.dart';
import 'dart:math';
import 'package:fl_chart/fl_chart.dart';


class LineChartClass extends StatelessWidget {
  const LineChartClass({
    super.key,
    required this.gradientColors,
  });

  final List<Color> gradientColors;

  @override
  Widget build(BuildContext context) {
    return LineChart(LineChartData(
        gridData: FlGridData(show: false),
        titlesData: FlTitlesData(show: false),
        borderData: FlBorderData(show: false),
        minX: 0,
        maxX: 10,
        minY: 0,
        maxY: 15,
        lineBarsData: [
          LineChartBarData(
            spots: [
              FlSpot(0, 5),
              FlSpot(1, 6),
              FlSpot(2, 8),
              FlSpot(4, 5),
              FlSpot(5, 6),
              FlSpot(6, 8),
              FlSpot(7, 10),
              FlSpot(8, 7),
              FlSpot(9, 10),
              FlSpot(10, 12.5),
            ],
            isCurved: true, // To create a smooth curve
            color: Colors.green,
            gradient: LinearGradient(
              colors: gradientColors,
            ),

            dotData: FlDotData(show: false),
            belowBarData: BarAreaData(
              show: true,
              gradient: LinearGradient(
                colors: gradientColors
                    .map((color) => color.withValues(alpha: 0.3))
                    .toList(),
              ),
            ),
          )
        ]));
  }
}