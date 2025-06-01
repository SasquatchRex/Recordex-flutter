import 'package:fl_chart/fl_chart.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Processing/Provider/main_provider.dart';
import '../topside.dart';

import 'Components/LineChart.dart';
import 'Components/BarChart.dart';
import 'Components/HalfCircleProgress.dart';
import 'Components/PercentageLine.dart';
import 'Components/ProfileDash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // ← MUST BE ADDED

class HomepageRightSide extends StatefulWidget {
  const HomepageRightSide(
      {super.key});

  // const RightSide({super.key});

  @override
  State<HomepageRightSide> createState() => _HomepageRightSideState();
}

class _HomepageRightSideState extends State<HomepageRightSide> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: Container(
              // width: widget.fullMenu? 0.6 * MediaQuery.of(context).size.width : 0.69* MediaQuery.of(context).size.width,
              // color: Colors.red,
              alignment: Alignment.topLeft,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    Wrap(
                      spacing: 20.w, // Horizontal spacing
                      runSpacing: 20.h, // Vertical spacing
                      alignment: WrapAlignment.start,
                      children: [
                        Welcome(),
                        Trial(),
                        ActiveUsers(),
                        TotalUsers(),
                        ActiveUsers(),
                        TotalUsers(),
                        MonthlyRevenue(),
                        Expenditure(),
                        Income(),


                      ],
                    ),
                  ],
                ),
              )
            ),
          ),
          EmployeeDash()
        ],
      ),
    );
  }
}
class Indicator extends StatelessWidget {
  const Indicator({
    super.key,
    required this.color,
    required this.text,
    required this.isSquare,
    this.size = 16,
    this.textColor,
  });
  final Color color;
  final String text;
  final bool isSquare;
  final double size;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: size.r,
          height: size.r,
          decoration: BoxDecoration(
            shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
            color: color,
          ),
        ),
        SizedBox(
          width: 4.w,
        ),
        Text(
          text,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        )
      ],
    );
  }
}

class EmployeeDash extends StatelessWidget {
  const EmployeeDash({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 0.2 * MediaQuery.of(context).size.width,


      alignment: Alignment.topCenter,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TopEmployeeDash(),
            SizedBox(height: 20.h,),
            ActiveEmployeeDash(),
          ],
        ),
      ),
    );
  }
}

class ActiveEmployeeDash extends StatelessWidget {
  const ActiveEmployeeDash({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      width: 350.w,
      decoration: BoxDecoration(
        color: Provider.of<AppColors>(context).appColors.primary,
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      child: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 8.0.w, vertical: 12.0.h),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Text(
                "Active Employees",
                style: TextStyle(
                    color: Provider.of<AppColors>(context).appColors.tertiaryText,
                    fontSize: 20.sp
                ),

              ),
              SizedBox(height: 10.h,),
              for(int i=1;i<=15;i++)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2.0),
                  child: GestureDetector(
                    onTap: () {
                      print("Option 1");
                    },
                    child: Container(
                      // color: Provider.of<AppColors>(context).appColors.secondary,

                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 20),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 20.r,
                                    // child: Image.asset("assets/profile.png"),
                                    backgroundColor: Colors.white24,
                                    backgroundImage: AssetImage(
                                        "assets/profile.png",

                                    ),
                                  ),
                                  SizedBox(width: 20.w,),
                                  Container(
                                    // width: 150.w,
                                    child: Text(
                                      "Prithak Lamsal",
                                      style: TextStyle(
                                          color: Provider.of<AppColors>(context).appColors.secondaryText,
                                          fontSize: 14.sp
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              SizedBox(width: 10.w,),
                              Icon(
                                Icons.circle,
                                color: Colors.green,
                                size: 12.r,
                              )
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
    );
  }
}

class TopEmployeeDash extends StatelessWidget {
  const TopEmployeeDash({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      width: 350.w,
      // height: 360.h,
      decoration: BoxDecoration(
        color: Provider.of<AppColors>(context).appColors.primary,
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        child: Column(
          children: [
            Text(
              "Top Employees",
              style: TextStyle(
                  color: Provider.of<AppColors>(context).appColors.tertiaryText,
                  fontSize: 20.sp
              ),
            ),
            SizedBox(height: 10.h,),
            for(int i=1;i<=5;i++)
              Padding(
                padding:  EdgeInsets.symmetric(vertical: 2.h),
                child: GestureDetector(
                  onTap: () {
                    print("Option 1");
                  },
                  child: Container(
                      // color: Provider.of<AppColors>(context).appColors.secondary,

                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 20),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 20.r,
                                  // child: Image.asset("assets/profile.png"),
                                  backgroundColor: Colors.white24,
                                  backgroundImage: AssetImage("assets/profile.png",),
                                ),
                                SizedBox(width: 20.w,),
                                Container(
                                  // width: 150.w,
                                  child: Text(
                                    "Prithak Lamsal",
                                    style: TextStyle(
                                        color: Provider.of<AppColors>(context).appColors.secondaryText,
                                        fontSize: 14.sp
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(width: 10.w,),
                            Text(
                              "${i} st",
                              style: TextStyle(
                                  color: Provider.of<AppColors>(context).appColors.NotificationBody,
                                  fontSize: 14.sp
                              ),
                            )
                          ],
                        ),
                      )
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}


class Welcome extends StatelessWidget {
  const Welcome({
    super.key,
  });

  String formatK(num value) {
    if (value >= 1000 ) {
      return "${(value / 1000).toStringAsFixed(1)}K";
    }
    return value.toString();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      width: Provider.of<General>(context).fullMenu?600.w : 650.w,
      height: 250.h,
      decoration: BoxDecoration(
        color: Provider.of<AppColors>(context).appColors.primary,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 20.w, right: 0, top: 15.h, bottom: 15.h),
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
                          padding:  EdgeInsets.all(3.0.r)
,
                          child: Profile_Dash(),
                        ),
                      ),
                      SizedBox(
                        width: 20.w,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Welcome back,",
                            style: TextStyle(color: Provider.of<AppColors>(context).appColors.QuaternaryText),
                          ),
                          // SizedBox(height: 10.h,),
                          Text(
                            "${Provider.of<Data>(context).username}!",
                            style:
                            TextStyle(color: Provider.of<AppColors>(context).appColors.tertiaryText, fontSize: 28.sp),
                          )
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 20.w,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        // mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "Rs. ${formatK(Provider.of<Data>(context).decodedResponse['total sale this month'] != null?Provider.of<Data>(context).decodedResponse['total sale this month'] : 0 )  }",
                            style: TextStyle(
                                color: Provider.of<AppColors>(context).appColors.tertiaryText,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w600),
                          ),
                          Text(
                            "This Month's Sale",
                            style: TextStyle(
                                color: Provider.of<AppColors>(context).appColors.tertiaryText,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w300),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          PercentageLine(
                            percentage: 64, // Fill 75% of the line
                            backgroundColor: Provider.of<AppColors>(context).appColors.QuaternaryText,
                            fillColor: Colors.green.shade400,
                            height: 6.h,
                            width: 100.w,
                          )
                        ],
                      ),
                      SizedBox(
                        width: 40.w,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        // mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "74%",
                            style: TextStyle(
                                color: Provider.of<AppColors>(context).appColors.tertiaryText,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w600),
                          ),
                          Text(
                            "Growth Rate",
                            style: TextStyle(
                                color: Provider.of<AppColors>(context).appColors.tertiaryText,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w300),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          PercentageLine(
                            percentage: 74, // Fill 75% of the line
                            backgroundColor: Provider.of<AppColors>(context).appColors.QuinaryText,
                            fillColor: Colors.red.shade400,
                            height: 6.h,
                            width: 100.w,
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


class Trial extends StatelessWidget {
  const Trial({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      curve: Curves.linear,
      width:  Provider.of<General>(context).fullMenu?490.w : 600.w,
      height: 250.h,
      decoration: BoxDecoration(
        color: Provider.of<AppColors>(context).appColors.primary,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 20.w, right: 0, top: 10.h, bottom: 0.h),
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      "Operated days this month",
                    style: TextStyle(
                      color: Provider.of<AppColors>(context).appColors.QuaternaryText,
                      fontSize: 16.sp
                    ),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Text(
                    "-",
                    style: TextStyle(
                        color: Provider.of<AppColors>(context).appColors.tertiaryText,
                      fontSize: 30.sp
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    "Present Days : ",
                    style: TextStyle(
                        color: Provider.of<AppColors>(context).appColors.QuaternaryText,
                        fontSize: 16.sp

                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Text(
                    "-",
                    style: TextStyle(
                        color: Colors.green,
                        fontSize: 30.sp
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    "Absent Days : ",
                    style: TextStyle(
                        color: Provider.of<AppColors>(context).appColors.QuaternaryText,
                        fontSize: 16.sp

                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Text(
                    "-",
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 30.sp
                    ),
                  ),
                ],
              ),
              Image.asset(
                  "assets/time.png",
                width: 250.r,  // ← Scales proportionally
                height: 250.r,
                // color: Colors.red,
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
      width: 250.w,
      height: 250.h,
      decoration: BoxDecoration(
        color: Provider.of<AppColors>(context).appColors.primary,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Padding(
        padding:  EdgeInsets.all(10.0.r)
,
        child: Column(
          children: [
            Text(
              "42.5K",
              style: TextStyle(
                  color: Provider.of<AppColors>(context).appColors.tertiaryText,
                  fontSize: 19.sp,
                  fontWeight: FontWeight.w600),
            ),
            Text(
              "Active Users",
              style: TextStyle(
                  color: Provider.of<AppColors>(context).appColors.tertiaryText,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w300),
            ),
            SizedBox(
              height: 30.h,
            ),
            HalfCircleProgress(
              percentage: 78, // Fill 75% of the half-circle
              backgroundColor: Provider.of<AppColors>(context).appColors.ActiveUsersBackground,
              progressColor: Provider.of<AppColors>(context).appColors.ActiveUsersProgress,
              strokeWidth: 12.w,
              size: 110,
            ),
            Container(
              width: 180.w,
              child: Text(
                "12.5K users increased from last month",
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: Provider.of<AppColors>(context).appColors.QuaternaryText,
                    fontSize: 14.sp,
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
      width: 250.w,
      height: 250.h,
      decoration: BoxDecoration(
        color: Provider.of<AppColors>(context).appColors.primary,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Padding(
        padding:  EdgeInsets.all(10.0.r)
,
        child: Column(
          children: [
            Text(
              "42.5K",
              style: TextStyle(
                  color: Provider.of<AppColors>(context).appColors.tertiaryText,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600),
            ),
            Text(
              "Total Users",
              style: TextStyle(
                  color: Provider.of<AppColors>(context).appColors.tertiaryText,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w300),
            ),
            SizedBox(
              height: 15.h,
            ),
            Container(
              height: 100.h,
              width: 150.w,
              child: LineChartClass(gradientColors: gradientColors),
            ),
            SizedBox(
              height: 15.h,
            ),
            Container(
              width: 180.w,
              child: Text(
                "12.5K users increased from last month",
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: Provider.of<AppColors>(context).appColors.QuaternaryText,
                    fontSize: 14.sp,
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

    return AnimatedContainer(
      duration: Duration(milliseconds: 400),
      curve: Curves.linear,
      width: 420.w,
      height: 370.h,
      decoration: BoxDecoration(
        color: Provider.of<AppColors>(context).appColors.primary,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Padding(
        padding:  EdgeInsets.all(10.0.r)
,
        child: Column(
          children: [
            Text(
              "Monthly Revenue",
              style: TextStyle(
                  color: Provider.of<AppColors>(context).appColors.tertiaryText,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 30.h,
            ),
            Container(
              height: 200.h,
              width: 350.w,
              child: BarChartWidget(),
            ),
            SizedBox(
              height: 15.h,
            ),
            Container(
              width: 350.w,
              child: Text(
                "Average monthly sale",
                textAlign: TextAlign.left,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: Provider.of<AppColors>(context).appColors.tertiaryText,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400),
              ),
            ),
            Row(
              children: [
                SizedBox(
                  width: 20.w,
                ),
                Text(
                  "68.9%",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.blueAccent,
                    fontSize: 34.sp,
                  ),
                ),
                SizedBox(
                  width: 15.w,
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


class Expenditure extends StatefulWidget {
  const Expenditure({
    super.key,
  });

  @override
  State<Expenditure> createState() => _ExpenditureState();
}

class _ExpenditureState extends State<Expenditure> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    List<Color> gradientColors = [
      Colors.lightGreenAccent,
      Colors.green,
    ];


    return AnimatedContainer(
      duration: Duration(milliseconds: 400),
      curve: Curves.easeInOut,
      width: Provider.of<General>(context).fullMenu? 330.w : 400.w,
      height: 370.h,
      decoration: BoxDecoration(
        color: Provider.of<AppColors>(context).appColors.primary,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Padding(
        padding:  EdgeInsets.all(20.0.r)
,
        child: Column(
          children: [
            Text(
              "Expenditure Chart",
              style: TextStyle(
                  color: Provider.of<AppColors>(context).appColors.tertiaryText,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 40.h,
            ),
            // Container(
            //   height: 150.h,
            //   width: 200,
            //   // color: Colors.red,
            //   child: PieChart(
            //     PieChartData(
            //       pieTouchData: PieTouchData(
            //         touchCallback: (FlTouchEvent event, pieTouchResponse) {
            //           setState(() {
            //             if (!event.isInterestedForInteractions || pieTouchResponse == null || pieTouchResponse.touchedSection == null) {
            //               touchedIndex = -1;
            //               return;
            //             }
            //             touchedIndex = pieTouchResponse
            //                 .touchedSection!.touchedSectionIndex;
            //           });
            //         },
            //       ),
            //       borderData: FlBorderData(
            //         show: false,
            //       ),
            //       sectionsSpace: 0,
            //       centerSpaceRadius: 40,
            //       sections: showingSections(),
            //     ),
            //   ),
            // ),
            //
            //
            // SizedBox(
            //   height: 15,
            // ),

            Row(
              children: [
                Expanded(
                    child: Container(
                      height: 150.h,
                        alignment: Alignment.topLeft,
                        // color: Colors.red,
                        // width: 250,
                      child: PieChart(
                        PieChartData(
                          pieTouchData: PieTouchData(
                            touchCallback: (FlTouchEvent event, pieTouchResponse) {
                              setState(() {
                                if (!event.isInterestedForInteractions || pieTouchResponse == null || pieTouchResponse.touchedSection == null) {
                                  touchedIndex = -1;
                                  return;
                                }
                                touchedIndex = pieTouchResponse
                                    .touchedSection!.touchedSectionIndex;
                              });
                            },
                          ),
                          borderData: FlBorderData(
                            show: false,
                          ),

                          sectionsSpace: 0,
                          centerSpaceRadius: 40.r,
                          sections: showingSections(),
                        ),
                      ),
                    ),
                ),
                SizedBox(width: 20.w,),
                Container(
                  // alignment: Alignment.bottomRight,
                  // color: Colors.red,
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Indicator(
                        color: Provider.of<AppColors>(context).appColors.PiechartColor1,
                        text: 'First',
                        textColor: Provider.of<AppColors>(context).appColors.secondaryText,
                        isSquare: true,
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Indicator(
                        color: Provider.of<AppColors>(context).appColors.PiechartColor2,
                        text: 'Second',
                        textColor: Provider.of<AppColors>(context).appColors.secondaryText,
                        isSquare: true,
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Indicator(
                        color: Provider.of<AppColors>(context).appColors.PiechartColor3,
                        text: 'Third',
                        textColor: Provider.of<AppColors>(context).appColors.secondaryText,
                        isSquare: true,
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Indicator(
                        color: Provider.of<AppColors>(context).appColors.PiechartColor4,
                        text: 'Fourth',
                        isSquare: true,
                        textColor: Provider.of<AppColors>(context).appColors.secondaryText,
                      ),
                      SizedBox(
                        height: 18.h,
                      ),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: 40.h,),

            Container(
              // width: 265,
              alignment: Alignment.centerLeft,
              child: Text(
                "Average monthly sale",
                textAlign: TextAlign.left,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: Provider.of<AppColors>(context).appColors.tertiaryText,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,

                ),
              ),
            ),
            Row(
              children: [
                SizedBox(
                  width: 20.w,
                ),
                Text(
                  "68.9%",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.blueAccent,
                    fontSize: 34.sp,
                  ),
                ),
                SizedBox(
                  width: 15.w,
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
  List<PieChartSectionData> showingSections() {
    return List.generate(4, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0.sp : 16.0.sp;
      final radius = isTouched ? 60.0.sp : 50.0.sp;
      const shadows = [Shadow(color: Colors.black, blurRadius: 0)];
      switch (i) {
        case 0:
          return PieChartSectionData(
            color:Provider.of<AppColors>(context).appColors.PiechartColor1 ,
            value: 40,
            title: '40%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Provider.of<AppColors>(context).appColors.primaryText,
              shadows: shadows,
            ),
          );
        case 1:
          return PieChartSectionData(
            color: Provider.of<AppColors>(context).appColors.PiechartColor2,
            value: 30,
            title: '30%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Provider.of<AppColors>(context).appColors.primaryText,
              shadows: shadows,
            ),
          );
        case 2:
          return PieChartSectionData(
            color: Provider.of<AppColors>(context).appColors.PiechartColor3,
            value: 15,
            title: '15%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Provider.of<AppColors>(context).appColors.primaryText,
              shadows: shadows,
            ),
          );
        case 3:
          return PieChartSectionData(
            color: Provider.of<AppColors>(context).appColors.PiechartColor4,
            value: 15,
            title: '15%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Provider.of<AppColors>(context).appColors.primaryText,
              shadows: shadows,
            ),
          );
        default:
          throw Error();
      }
    });
  }
}

class Income extends StatefulWidget {
  const Income({
    super.key,
  });

  @override
  State <Income> createState() => _IncomeState();
}

class _IncomeState extends State<Income> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    List<Color> gradientColors = [
      Colors.lightGreenAccent,
      Colors.green,
    ];


    return AnimatedContainer(
      duration: Duration(milliseconds: 400),
      curve: Curves.easeInOut,
      width: Provider.of<General>(context).fullMenu? 330.w : 400.w,
      // height: 370.h,
      decoration: BoxDecoration(
        color: Provider.of<AppColors>(context).appColors.primary,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Padding(
        padding:  EdgeInsets.all(20.0.r)
,
        child: Column(
          children: [
            Text(
              "Income Chart",
              style: TextStyle(
                  color: Provider.of<AppColors>(context).appColors.tertiaryText,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 40.h,
            ),
            // Container(
            //   height: 150,
            //   width: 200,
            //   // color: Colors.red,
            //   child: PieChart(
            //     PieChartData(
            //       pieTouchData: PieTouchData(
            //         touchCallback: (FlTouchEvent event, pieTouchResponse) {
            //           setState(() {
            //             if (!event.isInterestedForInteractions || pieTouchResponse == null || pieTouchResponse.touchedSection == null) {
            //               touchedIndex = -1;
            //               return;
            //             }
            //             touchedIndex = pieTouchResponse
            //                 .touchedSection!.touchedSectionIndex;
            //           });
            //         },
            //       ),
            //       borderData: FlBorderData(
            //         show: false,
            //       ),
            //       sectionsSpace: 0,
            //       centerSpaceRadius: 40,
            //       sections: showingSections(),
            //     ),
            //   ),
            // ),
            //
            //
            // SizedBox(
            //   height: 15,
            // ),

            Row(
              children: [
                Expanded(
                    child: Container(
                      height: 150.h,
                        alignment: Alignment.topLeft,
                        // color: Colors.red,
                        // width: 250,
                      child: PieChart(
                        PieChartData(
                          pieTouchData: PieTouchData(
                            touchCallback: (FlTouchEvent event, pieTouchResponse) {
                              setState(() {
                                if (!event.isInterestedForInteractions || pieTouchResponse == null || pieTouchResponse.touchedSection == null) {
                                  touchedIndex = -1;
                                  return;
                                }
                                touchedIndex = pieTouchResponse
                                    .touchedSection!.touchedSectionIndex;
                              });
                            },
                          ),
                          borderData: FlBorderData(
                            show: false,
                          ),
                          sectionsSpace: 0,
                          centerSpaceRadius: 40.r,
                          sections: showingSections(),
                        ),
                      ),
                    ),
                ),
                SizedBox(width: 20.w,),
                Container(
                  // alignment: Alignment.bottomRight,
                  // color: Colors.red,
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Indicator(
                        color: Provider.of<AppColors>(context).appColors.PiechartColor5,
                        text: 'First',
                        isSquare: true,
                        textColor: Provider.of<AppColors>(context).appColors.secondaryText,
                      ),
                      SizedBox(
                        height: 4.h,
                      ),
                      Indicator(
                        color: Provider.of<AppColors>(context).appColors.PiechartColor6,
                        text: 'Second',
                        isSquare: true,
                        textColor: Provider.of<AppColors>(context).appColors.secondaryText,
                      ),
                      SizedBox(
                        height: 4.h,
                      ),
                      Indicator(
                        color: Provider.of<AppColors>(context).appColors.PiechartColor7,
                        text: 'Third',
                        isSquare: true,
                        textColor: Provider.of<AppColors>(context).appColors.secondaryText,
                      ),
                      SizedBox(
                        height: 4.h,
                      ),
                      Indicator(
                        color: Provider.of<AppColors>(context).appColors.PiechartColor8,
                        text: 'Fourth',
                        isSquare: true,
                        textColor: Provider.of<AppColors>(context).appColors.secondaryText,
                      ),
                      SizedBox(
                        height: 18.h,
                      ),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: 40.h,),

            Container(
              // width: 265,
              alignment: Alignment.centerLeft,
              child: Text(
                "Average monthly sale",
                textAlign: TextAlign.left,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: Provider.of<AppColors>(context).appColors.tertiaryText,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,

                ),
              ),
            ),
            Row(
              children: [
                SizedBox(
                  width: 20.w,
                ),
                Text(
                  "68.9%",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.blueAccent,
                    fontSize: 34.sp,
                  ),
                ),
                SizedBox(
                  width: 15.w,
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
  List<PieChartSectionData> showingSections() {
    return List.generate(4, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0.sp : 16.0.sp;
      final radius = isTouched ? 60.0.r : 50.0.r;
      const shadows = [Shadow(color: Colors.black, blurRadius: 0)];
      switch (i) {
        case 0:
          return PieChartSectionData(
            color:Provider.of<AppColors>(context).appColors.PiechartColor5 ,
            value: 40,
            title: '40%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Provider.of<AppColors>(context).appColors.primaryText,
              shadows: shadows,
            ),
          );
        case 1:
          return PieChartSectionData(
            color: Provider.of<AppColors>(context).appColors.PiechartColor6,
            value: 30,
            title: '30%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Provider.of<AppColors>(context).appColors.primaryText,
              shadows: shadows,
            ),
          );
        case 2:
          return PieChartSectionData(
            color: Provider.of<AppColors>(context).appColors.PiechartColor7,
            value: 15,
            title: '15%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Provider.of<AppColors>(context).appColors.primaryText,
              shadows: shadows,
            ),
          );
        case 3:
          return PieChartSectionData(
            color: Provider.of<AppColors>(context).appColors.PiechartColor8,
            value: 15,
            title: '15%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Provider.of<AppColors>(context).appColors.primaryText,
              shadows: shadows,
            ),
          );
        default:
          throw Error();
      }
    });
  }
}








