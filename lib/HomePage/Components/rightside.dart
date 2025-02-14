import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Provider/main_provider.dart';
import 'topside.dart';
import 'dart:math';
import 'package:fl_chart/fl_chart.dart';

class RightSide extends StatefulWidget {
  final VoidCallback onToggleMenu;
  final VoidCallback toggleNotification;
  final bool fullMenu;
  final bool notification;

  const RightSide(
      {required this.onToggleMenu,
      required this.fullMenu,
      required this.notification,
      required this.toggleNotification});

  // const RightSide({super.key});

  @override
  State<RightSide> createState() => _RightSideState();
}

class _RightSideState extends State<RightSide> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // width: widget.fullMenu
      //     ? 0.80 * MediaQuery.of(context).size.width
      //     : 0.89 * MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Provider.of<AppColors>(context).appColors.background,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Stack(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Topside(
                    onToggleMenu: widget.onToggleMenu,
                    toggleNotification: widget.toggleNotification,
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.topLeft,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        children: [
                          Wrap(
                            spacing: 20, // Horizontal spacing
                            runSpacing: 20, // Vertical spacing
                            alignment: WrapAlignment.start,
                            children: [
                              Welcome(),
                              ActiveUsers(),
                              TotalUsers(),
                              MonthlyRevenue(), // Will move to a new row if needed
                            ],
                          ),
                        ],
                      ),
                    )
                  ),
                ),

              ],
            ),
            if (widget.notification)
              Positioned(
                right: 0,
                top: 80,
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 200),
                  curve: Curves.easeInOut,
                  width: 300,
                  height: 400,
                  decoration: BoxDecoration(
                      color: Provider.of<AppColors>(context).appColors.primary,
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                    child: Column(
                      children: [
                        Text(
                          "Notifications",
                          style: TextStyle(
                            color: Provider.of<AppColors>(context).appColors.tertiaryText,
                            fontSize: 20
                          ),

                        ),
                        SizedBox(height: 10,),
                        for(int i=1;i<=5;i++)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2.0),
                          child: GestureDetector(
                            onTap: () {
                              print("Option 1");
                            },
                            child: Container(
                                color: Provider.of<AppColors>(context).appColors.secondary,
                                width: 300,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Heading 1",
                                        style: TextStyle(
                                          color: Provider.of<AppColors>(context).appColors.NotificationHeader,
                                        ),
                                      ),
                                      SizedBox(height: 2,),
                                      Text(
                                        "This is the description for heading 1",
                                        style: TextStyle(
                                          color: Provider.of<AppColors>(context).appColors.NotificationBody,
                                          fontSize: 12
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
          ],
        ),
      ),
      // child: Text("Hello"),
    );
  }
}

class Welcome extends StatelessWidget {
  const Welcome({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      width: 600,
      height: 250,
      decoration: BoxDecoration(
        color: Provider.of<AppColors>(context).appColors.primary,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 20, right: 0, top: 15, bottom: 15),
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        // alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Provider.of<AppColors>(context).appColors.ProfileDecoration,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Profile_Dash(),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Welcome back,",
                            style: TextStyle(color: Provider.of<AppColors>(context).appColors.QuaternaryText),
                          ),
                          // SizedBox(height: 10,),
                          Text(
                            "Prithak Lamsal!",
                            style:
                                TextStyle(color: Provider.of<AppColors>(context).appColors.tertiaryText, fontSize: 28),
                          )
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        // mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "\$65.4K",
                            style: TextStyle(
                                color: Provider.of<AppColors>(context).appColors.tertiaryText,
                                fontSize: 20,
                                fontWeight: FontWeight.w600),
                          ),
                          Text(
                            "Today's Sale",
                            style: TextStyle(
                                color: Provider.of<AppColors>(context).appColors.tertiaryText,
                                fontSize: 14,
                                fontWeight: FontWeight.w300),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          PercentageLine(
                            percentage: 64, // Fill 75% of the line
                            backgroundColor: Provider.of<AppColors>(context).appColors.QuaternaryText,
                            fillColor: Colors.green.shade400,
                            height: 6,
                            width: 100,
                          )
                        ],
                      ),
                      SizedBox(
                        width: 40,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        // mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "74%",
                            style: TextStyle(
                                color: Provider.of<AppColors>(context).appColors.tertiaryText,
                                fontSize: 20,
                                fontWeight: FontWeight.w600),
                          ),
                          Text(
                            "Growth Rate",
                            style: TextStyle(
                                color: Provider.of<AppColors>(context).appColors.tertiaryText,
                                fontSize: 14,
                                fontWeight: FontWeight.w300),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          PercentageLine(
                            percentage: 74, // Fill 75% of the line
                            backgroundColor: Provider.of<AppColors>(context).appColors.QuinaryText,
                            fillColor: Colors.red.shade400,
                            height: 6,
                            width: 100,
                          )
                        ],
                      )
                    ],
                  )
                ],
              ),
              Image.asset(
                "assets/photo.png",
                scale: 0.5,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ActiveUsers extends StatelessWidget {
  const ActiveUsers({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      height: 250,
      decoration: BoxDecoration(
        color: Provider.of<AppColors>(context).appColors.primary,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Text(
              "42.5K",
              style: TextStyle(
                  color: Provider.of<AppColors>(context).appColors.tertiaryText,
                  fontSize: 20,
                  fontWeight: FontWeight.w600),
            ),
            Text(
              "Active Users",
              style: TextStyle(
                  color: Provider.of<AppColors>(context).appColors.tertiaryText,
                  fontSize: 14,
                  fontWeight: FontWeight.w300),
            ),
            SizedBox(
              height: 30,
            ),
            HalfCircleProgress(
              percentage: 78, // Fill 75% of the half-circle
              backgroundColor: Provider.of<AppColors>(context).appColors.ActiveUsersBackground,
              progressColor: Provider.of<AppColors>(context).appColors.ActiveUsersProgress,
              strokeWidth: 12,
              size: 110,
            ),
            Container(
              width: 180,
              child: Text(
                "12.5K users increased from last month",
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: Provider.of<AppColors>(context).appColors.QuaternaryText,
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class TotalUsers extends StatelessWidget {
  const TotalUsers({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    List<Color> gradientColors = [
      Colors.lightGreenAccent,
      Colors.green,
    ];

    return Container(
      width: 250,
      height: 250,
      decoration: BoxDecoration(
        color: Provider.of<AppColors>(context).appColors.primary,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Text(
              "42.5K",
              style: TextStyle(
                  color: Provider.of<AppColors>(context).appColors.tertiaryText,
                  fontSize: 20,
                  fontWeight: FontWeight.w600),
            ),
            Text(
              "Total Users",
              style: TextStyle(
                  color: Provider.of<AppColors>(context).appColors.tertiaryText,
                  fontSize: 14,
                  fontWeight: FontWeight.w300),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              height: 100,
              width: 150,
              child: LineChart(LineChartData(
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
                  ])),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              width: 180,
              child: Text(
                "12.5K users increased from last month",
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: Provider.of<AppColors>(context).appColors.QuaternaryText,
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MonthlyRevenue extends StatelessWidget {
  const MonthlyRevenue({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    List<Color> gradientColors = [
      Colors.lightGreenAccent,
      Colors.green,
    ];

    return Container(
      width: 420,
      height: 370,
      decoration: BoxDecoration(
        color: Provider.of<AppColors>(context).appColors.primary,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Text(
              "Monthly Revenue",
              style: TextStyle(
                  color: Provider.of<AppColors>(context).appColors.tertiaryText,
                  fontSize: 20,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              height: 200,
              width: 350,
              child: BarChartWidget(),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              width: 350,
              child: Text(
                "Average monthly sale",
                textAlign: TextAlign.left,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: Provider.of<AppColors>(context).appColors.tertiaryText,
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
              ),
            ),
            Row(
              children: [
                SizedBox(
                  width: 20,
                ),
                Text(
                  "68.9%",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.blueAccent,
                    fontSize: 34,
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Container(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    "3.45%",
                    style: TextStyle(color: Colors.green),
                  ),
                ),
                Icon(
                  Icons.arrow_drop_up,
                  color: Colors.green,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

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
            strokeWidth: 1,
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
                    style:  TextStyle(color: Provider.of<AppColors>(context).appColors.primaryText, fontSize: 12),
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
                  style:  TextStyle(color: Provider.of<AppColors>(context).appColors.tertiaryText, fontSize: 12),
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

class Profile_Dash extends StatelessWidget {
  const Profile_Dash({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 60,
      height: 60,
      child: ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: Image.asset(
            "assets/profile.png",
            scale: 1.8,
            fit: BoxFit.cover,
          )),
    );
  }
}

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
