import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Provider/main_provider.dart';
import 'topside.dart';

import 'Components/LineChart.dart';
import 'Components/BarChart.dart';
import 'Components/HalfCircleProgress.dart';
import 'Components/PercentageLine.dart';
import 'Components/ProfileDash.dart';

class RightSide extends StatefulWidget {
  const RightSide(
      {super.key});

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
        padding: const EdgeInsets.only(top: 20.0,bottom:20,right: 0,left: 20),
        // padding: const EdgeInsets.only(top: 20,bottom: 20),
        child: Stack(
          children: [
            Column(

              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Topside(),
                ),
                Expanded(
                  child: Container(
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
                                    spacing: 20, // Horizontal spacing
                                    runSpacing: 20, // Vertical spacing
                                    alignment: WrapAlignment.start,
                                    children: [
                                      Welcome(),
                                      Trial(),
                                      MonthlyRevenue(),
                                      ActiveUsers(),
                                      TotalUsers(),
                                      ActiveUsers(),
                                      TotalUsers(),

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
                  ),
                ),

              ],
            ),
            if (Provider.of<General>(context).notification)
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
              ),



          ],
        ),
      ),
      // child: Text("Hello"),
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
            SizedBox(height: 20,),
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
      width: 350,
      decoration: BoxDecoration(
        color: Provider.of<AppColors>(context).appColors.primary,
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Text(
                "Active Employees",
                style: TextStyle(
                    color: Provider.of<AppColors>(context).appColors.tertiaryText,
                    fontSize: 20
                ),

              ),
              SizedBox(height: 10,),
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
                                    // child: Image.asset("assets/profile.png"),
                                    backgroundColor: Colors.white24,
                                    backgroundImage: AssetImage("assets/profile.png",),
                                  ),
                                  SizedBox(width: 20,),
                                  Container(
                                    // width: 150,
                                    child: Text(
                                      "Prithak Lamsal",
                                      style: TextStyle(
                                          color: Provider.of<AppColors>(context).appColors.secondaryText,
                                          fontSize: 14
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              SizedBox(width: 10,),
                              Icon(
                                Icons.circle,
                                color: Colors.green,
                                size: 12,
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
      width: 350,
      // height: 360,
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
                                  // child: Image.asset("assets/profile.png"),
                                  backgroundColor: Colors.white24,
                                  backgroundImage: AssetImage("assets/profile.png",),
                                ),
                                SizedBox(width: 20,),
                                Container(
                                  // width: 150,
                                  child: Text(
                                    "Prithak Lamsal",
                                    style: TextStyle(
                                        color: Provider.of<AppColors>(context).appColors.secondaryText,
                                        fontSize: 14
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(width: 10,),
                            Text(
                              "${i} st",
                              style: TextStyle(
                                  color: Provider.of<AppColors>(context).appColors.NotificationBody,
                                  fontSize: 14
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

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      width: Provider.of<General>(context).fullMenu?600 : 700,
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


class Trial extends StatelessWidget {
  const Trial({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      width:  Provider.of<General>(context).fullMenu?500 : 550,
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
                  Text(
                      "Total operated days this month",
                    style: TextStyle(
                      color: Provider.of<AppColors>(context).appColors.QuaternaryText
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "18",
                    style: TextStyle(
                        color: Provider.of<AppColors>(context).appColors.tertiaryText,
                      fontSize: 30
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Present Days : ",
                    style: TextStyle(
                        color: Provider.of<AppColors>(context).appColors.QuaternaryText
                    ),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Text(
                    "18",
                    style: TextStyle(
                        color: Colors.green,
                        fontSize: 30
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Absent Days : ",
                    style: TextStyle(
                        color: Provider.of<AppColors>(context).appColors.QuaternaryText
                    ),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Text(
                    "0",
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 30
                    ),
                  ),
                ],
              ),
              Image.asset(
                  "assets/time.png",
                scale: 8,
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
              child: LineChartClass(gradientColors: gradientColors),
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








