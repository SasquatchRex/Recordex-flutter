import 'package:flutter/material.dart';
import 'topside.dart';
import 'dart:math';
import 'package:fl_chart/fl_chart.dart';


class RightSide extends StatefulWidget {
  final VoidCallback onToggleMenu;
  final bool fullMenu;

  const RightSide({required this.onToggleMenu, required this.fullMenu});

  // const RightSide({super.key});

  @override
  State<RightSide> createState() => _RightSideState();
}

class _RightSideState extends State<RightSide> {
  @override
  Widget build(BuildContext context) {
    return  Container(
      width: widget.fullMenu? 0.80* MediaQuery.of(context).size.width : 0.905* MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Colors.black,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Topside(onToggleMenu: widget.onToggleMenu),

            SizedBox(height: 50,),

            Container(
              alignment: Alignment.topLeft,
              child: Column(
                children: [
                  Row(
                    children: [
                      Welcome(),
                      SizedBox(width: 40,),
                      ActiveUsers() ,
                      SizedBox(width: 40,),
                      TotalUsers(),
                    ],
                  )
                ],
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
    return Container(
      width: 600,
      height: 250,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 20,right: 0, top: 15, bottom: 15),
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
                            color: Colors.blue.withOpacity(0.5)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Profile_Dash(),
                          ),
                      ),
                      SizedBox(width: 20,),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              "Welcome back,",
                            style: TextStyle(
                              color: Colors.white30
                            ),
                          ),
                          // SizedBox(height: 10,),
                          Text(
                              "Prithak Lamsal!",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 28
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: 30,),
                  Row(
                    children: [
                      SizedBox(width: 20,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        // mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "\$65.4K",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 20,
                              fontWeight: FontWeight.w600
                            ),
                          ),
                          Text(
                            "Today's Sale",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                              fontWeight: FontWeight.w300
                            ),
                          ),
                          SizedBox(height: 10,),

                          PercentageLine(
                            percentage: 64, // Fill 75% of the line
                            backgroundColor: Colors.white12,
                            fillColor: Colors.green.shade400,
                            height: 6,
                            width: 100,
                          )

                        ],
                      ),
                      SizedBox(width: 40,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        // mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "74%",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 20,
                              fontWeight: FontWeight.w600
                            ),
                          ),
                          Text(
                            "Growth Rate",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                              fontWeight: FontWeight.w300
                            ),
                          ),
                          SizedBox(height: 10,),

                          PercentageLine(
                            percentage: 74, // Fill 75% of the line
                            backgroundColor: Colors.white12,
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
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Text(
                "42.5K",
              style: TextStyle(
                  color: Colors.white70,
                  fontSize: 20,
                  fontWeight: FontWeight.w600
              ),

            ),
            Text(
                "Active Users",
              style: TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                  fontWeight: FontWeight.w300
              ),
            ),
            SizedBox(height: 30,),
            HalfCircleProgress(
              percentage: 78, // Fill 75% of the half-circle
              backgroundColor: Colors.grey[900]!,
              progressColor: Colors.blue.shade900,
              strokeWidth: 12,
              size: 110,
            ),
            Container(
              width: 180,
              child: Text(
                "12.5K users increased from last month",
                textAlign: TextAlign.center ,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: Colors.white30,
                    fontSize: 14,
                    fontWeight: FontWeight.w400
                ),
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
    return Container(
      width: 250,
      height: 250,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Text(
                "42.5K",
              style: TextStyle(
                  color: Colors.white70,
                  fontSize: 20,
                  fontWeight: FontWeight.w600
              ),

            ),
            Text(
                "Active Users",
              style: TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                  fontWeight: FontWeight.w300
              ),
            ),
            SizedBox(height: 30,),
            // LineChart(
            //   LineChartData(
            //     gridData: FlGridData(show: false),
            //     titlesData: FlTitlesData(show: false),
            //     borderData: FlBorderData(show: true),
            //     minX: 0,
            //     maxX: 10,
            //     minY: 0,
            //     maxY: 10,
            //     lineBarsData: [
            //       LineChartBarData(
            //         spots: [
            //           FlSpot(0, 0),
            //           FlSpot(1, 1),
            //           FlSpot(2, 2),
            //           FlSpot(3, 3),
            //
            //         ],
            //         isCurved: true, // To create a smooth curve
            //         // color: Colors.green,
            //         dotData: FlDotData(show: false),
            //         belowBarData: BarAreaData(show: false),
            //       )
            //     ]
            //   )
            // ),
            Container(
              width: 180,
              child: Text(
                "12.5K users increased from last month",
                textAlign: TextAlign.center ,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: Colors.white30,
                    fontSize: 14,
                    fontWeight: FontWeight.w400
                ),
              ),
            )
          ],
        ),
      ),

    );
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
          )
      ),
    );
  }
}


class PercentageLine extends StatelessWidget {
  final double percentage; // Percentage to fill (0 to 100)
  final Color backgroundColor;
  final Color fillColor;
  final double height;
  final double width;

  const PercentageLine({
    Key? key,
    required this.percentage,
    this.backgroundColor = Colors.white60,
    this.fillColor = Colors.blue,
    this.height = 10.0,
    this.width = 40
  }) : super(key: key);

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
              color: Colors.white,
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
      pi *3/4, // Start from left
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
      pi*3/4, // Start from left
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


