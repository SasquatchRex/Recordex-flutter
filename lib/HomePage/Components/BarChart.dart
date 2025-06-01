import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Processing/Provider/main_provider.dart';
import '../../topside.dart';
import 'dart:math';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // ← MUST BE ADDED

class BarChartWidget extends StatelessWidget {
  const BarChartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        backgroundColor: Colors.transparent,
        maxY: 70,
        barGroups: _chartData(),
        borderData: FlBorderData(show: false),
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false, // Hide vertical grid lines
          checkToShowHorizontalLine: (value) =>
          true, // Show all horizontal lines
          getDrawingHorizontalLine: (value) => FlLine(
            color: Colors.white.withOpacity(0.2),
            strokeWidth: 1.w,
          ),
        ),
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 40,
              getTitlesWidget: (value, meta) {
                return Text(
                  value.toInt().toString(),
                  style:  TextStyle(color: Provider.of<AppColors>(context).appColors.primaryText, fontSize: 12.sp),
                );
              },
              interval: 10,

            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                List<String> months = [
                  'Jan',
                  'Feb',
                  'Mar',
                  'Apr',
                  'May',
                  'Jun',
                  'Jul',
                  'Aug',
                  'Sep'
                ];

                return Text(
                  months[value.toInt()],
                  style:  TextStyle(color: Provider.of<AppColors>(context).appColors.tertiaryText, fontSize: 12.sp),
                );
              },
              interval: 1,
            ),
          ),
          topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false)), // Remove top text
          rightTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false)), // Remove right text
        ),
      ),
    );
  }

  List<BarChartGroupData> _chartData() {
    List<double> data = [10, 35, 40, 50, 25, 20, 15, 30, 18];
    double maxYValue =
        (data.reduce((a, b) => a > b ? a : b) / 10).ceil() * 10 + 10;

    return List.generate(data.length, (index) {
      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: data[index],
            gradient: const LinearGradient(
              colors: [Colors.cyan, Colors.greenAccent],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
            width: 15,
            borderRadius: BorderRadius.circular(5),
          ),
        ],
      );
    });
  }
}